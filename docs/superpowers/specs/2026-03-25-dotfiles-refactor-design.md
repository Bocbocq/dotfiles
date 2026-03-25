# Dotfiles Refactor & Databricks Setup — Design Spec

**Date:** 2026-03-25
**Branch:** rimes

## Goals

1. Consolidate the NixOS Home Manager module structure (too many small files)
2. Fix `LD_LIBRARY_PATH` not being set after WSL restart
3. Persist `DATABRICKS_RUNTIME_VERSION=connect` across shell sessions
4. Fix `stop-hook.sh` permission denied error (ralph-loop plugin)
5. Clean up macOS artifacts from Stow-managed shell config

## Constraints

- Stow manages all shell config (`.zshrc`, `.zshenv`) — Home Manager is packages-only
- No changes to `hosts/media-server/` — it has its own `home.nix` and is unaffected
- Minimal risk: restructure without changing behaviour

---

## Section 1 — NixOS module restructure

### Current state (11 files)

```
home/
  core.nix
  code/default.nix + lua.nix + python.nix + nix.nix + rust.nix + js.nix + common.nix
  programs/default.nix + git.nix + commons.nix + docker.nix + editors.nix
  shell/default.nix + shells.nix + terminals.nix
```

### Target state (5 files)

```
home/
  core.nix          (unchanged)
  dev.nix           (merges code/)
  tools.nix         (merges programs/)
  shell.nix         (merges shell/)
  activation.nix    (new)
```

### File contents

**`home/dev.nix`** — all language toolchains and dev LSP/linting tools:
- Languages: `python312`, `uv`, `poetry`, `cargo`, `nodejs`
- Python tooling: `black`, `isort`, `flake8`, `ruff`, `basedpyright`, `pyright`, `mypy`
- Nix tooling: `nixd`, `alejandra`, `statix`, `deadnix`
- Markdown: `markdownlint-cli2`, `markdown-toc`, `marksman`
- Lua: `lua`, `stylua`, `lua-language-server`, `luajitPackages.luarocks`

**`home/tools.nix`** — CLI utilities, editor, git tools, docker:
- CLI: `bat`, `dua`, `entr`, `eza`, `fd`, `fzf`, `gcc`, `gnumake`, `ripgrep`, `unzip`, `zoxide`, `zip`, `btop`, `tree-sitter`, `stow`
- Git: `lazygit`, `delta`, `github-cli`
- Editors: `neovim-unwrapped`
- Docker: `docker`, `lazydocker`
- Misc: `bash-language-server`, `databricks-cli`

**`home/shell.nix`** — shell runtime packages and the LD library session var:
- Packages: `zsh`, `oh-my-posh`, `starship`, `tmux`, `tmuxinator`, `sesh`, `gum`, `ghostty`
- `home.sessionVariables.LD_LIBRARY_PATH = "${pkgs.gcc.cc.lib}/lib:$LD_LIBRARY_PATH"`

**`home/activation.nix`** — fix claude plugin `.sh` permissions after every rebuild:
```nix
home.activation.fixClaudePluginPermissions =
  lib.hm.dag.entryAfter ["writeBoundary"] ''
    find "$HOME/.claude/plugins/marketplaces" -name "*.sh" -exec chmod +x {} \;
  '';
```

### `hosts/wsl/home.nix` after change

```nix
{ pkgs, ... }: {
  imports = [
    ../../home/core.nix
    ../../home/dev.nix
    ../../home/tools.nix
    ../../home/shell.nix
    ../../home/activation.nix
  ];
}
```

### Deleted

The entire `home/code/`, `home/programs/`, and `home/shell/` directories are removed.

---

## Section 2 — Stow shell config fixes

### `.zshenv` (full replacement)

```zsh
# Source Home Manager session vars (provides LD_LIBRARY_PATH etc.)
[ -f ~/.nix-profile/etc/profile.d/hm-session-vars.sh ] && \
  source ~/.nix-profile/etc/profile.d/hm-session-vars.sh

# Databricks
export DATABRICKS_RUNTIME_VERSION="connect"

# uv
export PATH="/home/boc/.local/bin:$PATH"
```

Removes:
- macOS `uv` path (`/Users/anthonybocquet/...`)
- ZVM exports (`ZVM_INSTALL`, `ZVM` PATH entries)

### `.zshrc` (targeted removals only)

Remove the following dead macOS blocks, leave everything else untouched:

```zsh
# DELETE — macOS Java
export JAVA_HOME="/Library/Java/JavaVirtualMachines/sapmachine-25.jdk/Contents/Home"

# DELETE — macOS NVM (references $HOMEBREW_PREFIX, does nothing on Linux)
export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && ...
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && ...
```

Everything else (zinit, plugins, history, fzf theme, sesh helper, starship, zoxide, GPG) is preserved as-is.

---

## Why `LD_LIBRARY_PATH` was broken

`home.sessionVariables` writes to `~/.nix-profile/etc/profile.d/hm-session-vars.sh`. This file is only sourced automatically from `.profile` / `.zprofile`. On WSL with zsh as the default shell, neither file is sourced on new terminals — only `.zshenv` and `.zshrc` are. Explicitly sourcing the HM vars file from `.zshenv` makes it reliable on every shell invocation.

---

## Testing

After `sudo nixos-rebuild switch --flake .#wsl`:

```bash
# Verify LD_LIBRARY_PATH is set
echo $LD_LIBRARY_PATH   # should contain gcc lib path

# Verify Databricks runtime
echo $DATABRICKS_RUNTIME_VERSION   # should print "connect"

# Verify hook is executable
ls -la ~/.claude/plugins/marketplaces/claude-plugins-official/plugins/ralph-loop/hooks/stop-hook.sh
# should show -rwxr-xr-x

# Verify Databricks Connect works
cd ~/edm_core && poetry run python -m rimesedm.main
```
