# Dotfiles Refactor & Databricks Setup — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Consolidate NixOS Home Manager modules from 11 files into 5, fix LD_LIBRARY_PATH on WSL restart, persist DATABRICKS_RUNTIME_VERSION, fix ralph-loop hook permissions, and strip macOS cruft from Stow-managed shell config.

**Architecture:** Home Manager strictly manages packages (new consolidated files under `home/`); Stow manages all shell config (`.zshenv`, `.zshrc`). LD_LIBRARY_PATH is written by Home Manager session vars and sourced explicitly from `.zshenv`. Hook permissions are fixed by a `home.activation` script that runs after every rebuild.

**Tech Stack:** NixOS + Home Manager, GNU Stow, zsh

**Spec:** `docs/superpowers/specs/2026-03-25-dotfiles-refactor-design.md`

---

## File Map

| Action | Path | Responsibility |
|--------|------|----------------|
| Create | `nixos/home/dev.nix` | All language toolchains (Python, Lua, Rust, JS, Nix, Markdown) |
| Create | `nixos/home/tools.nix` | CLI utils, git tools, docker, editor, databricks-cli |
| Create | `nixos/home/shell.nix` | Shell packages + LD_LIBRARY_PATH session var |
| Create | `nixos/home/activation.nix` | chmod +x for claude plugin hooks |
| Modify | `nixos/hosts/wsl/home.nix` | Update imports to new files |
| Delete | `nixos/home/code/` | Replaced by dev.nix |
| Delete | `nixos/home/programs/` | Replaced by tools.nix |
| Delete | `nixos/home/shell/` | Replaced by shell.nix |
| Modify | `zsh/.zshenv` | Source HM session vars, add DATABRICKS_RUNTIME_VERSION, strip macOS paths |
| Modify | `zsh/.zshrc` | Remove macOS Java and NVM blocks |

---

## Task 1: Create `home/dev.nix`

**Files:**
- Create: `nixos/home/dev.nix`

- [ ] **Step 1: Create the file**

```nix
{pkgs, ...}: {
  home.packages = with pkgs; [
    # Python
    python312
    uv
    poetry
    black
    isort
    python3Packages.flake8
    ruff
    basedpyright
    pyright
    mypy

    # Lua
    lua
    stylua
    lua-language-server
    luajitPackages.luarocks

    # Rust
    cargo

    # JavaScript
    nodejs

    # Nix
    nixd
    alejandra
    statix
    deadnix

    # Markdown / common dev tools
    markdownlint-cli2
    markdown-toc
    marksman
  ];
}
```

- [ ] **Step 2: Verify file parses**

```bash
cd ~/dotfiles/nixos && nix eval --file home/dev.nix --apply builtins.typeOf
```

Expected: `"lambda"`

- [ ] **Step 3: Commit**

```bash
git add nixos/home/dev.nix
git commit -m "refactor: add home/dev.nix consolidating language toolchains"
```

---

## Task 2: Create `home/tools.nix`

**Files:**
- Create: `nixos/home/tools.nix`

- [ ] **Step 1: Create the file**

```nix
{pkgs, ...}: {
  home.packages = with pkgs; [
    # Git
    lazygit
    delta
    github-cli

    # CLI utils
    stow
    bat
    dua
    entr
    eza
    fd
    fzf
    gcc
    gnumake
    ripgrep
    unzip
    zoxide
    zip
    btop
    tree-sitter
    bash-language-server
    databricks-cli

    # Docker
    docker
    lazydocker

    # Editor
    neovim-unwrapped
  ];
}
```

- [ ] **Step 2: Verify file parses**

```bash
cd ~/dotfiles/nixos && nix eval --file home/tools.nix --apply builtins.typeOf
```

Expected: `"lambda"`

- [ ] **Step 3: Commit**

```bash
git add nixos/home/tools.nix
git commit -m "refactor: add home/tools.nix consolidating CLI utils, git tools, docker, editor"
```

---

## Task 3: Create `home/shell.nix`

**Files:**
- Create: `nixos/home/shell.nix`

- [ ] **Step 1: Create the file**

```nix
{pkgs, ...}: {
  home.packages = with pkgs; [
    zsh
    oh-my-posh
    starship
    tmux
    tmuxinator
    sesh
    gum
    ghostty
  ];
  home.sessionVariables = {
    LD_LIBRARY_PATH = "${pkgs.gcc.cc.lib}/lib:$LD_LIBRARY_PATH";
  };
}
```

- [ ] **Step 2: Verify file parses**

```bash
cd ~/dotfiles/nixos && nix eval --file home/shell.nix --apply builtins.typeOf
```

Expected: `"lambda"`

- [ ] **Step 3: Commit**

```bash
git add nixos/home/shell.nix
git commit -m "refactor: add home/shell.nix consolidating shell packages and LD_LIBRARY_PATH"
```

---

## Task 4: Create `home/activation.nix`

**Files:**
- Create: `nixos/home/activation.nix`

- [ ] **Step 1: Create the file**

```nix
{lib, ...}: {
  home.activation.fixClaudePluginPermissions =
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      find "$HOME/.claude/plugins/marketplaces" -name "*.sh" -exec chmod +x {} \;
    '';
}
```

- [ ] **Step 2: Verify file parses**

```bash
cd ~/dotfiles/nixos && nix eval --file home/activation.nix --apply builtins.typeOf
```

Expected: `"lambda"`

- [ ] **Step 3: Commit**

```bash
git add nixos/home/activation.nix
git commit -m "fix: add home/activation.nix to chmod +x claude plugin hook scripts"
```

---

## Task 5: Update `hosts/wsl/home.nix` imports

**Files:**
- Modify: `nixos/hosts/wsl/home.nix`

- [ ] **Step 1: Replace the file contents**

```nix
{...}: {
  imports = [
    ../../home/core.nix
    ../../home/dev.nix
    ../../home/tools.nix
    ../../home/shell.nix
    ../../home/activation.nix
  ];
}
```

- [ ] **Step 2: Commit**

```bash
git add nixos/hosts/wsl/home.nix
git commit -m "refactor: update wsl home.nix to use consolidated home modules"
```

---

## Task 6: Rebuild NixOS to verify new structure

- [ ] **Step 1: Run rebuild**

```bash
cd ~/dotfiles/nixos && sudo nixos-rebuild switch --flake .#wsl
```

Expected: build completes without errors and prints `activating the configuration`.

If it fails, read the error carefully — most likely a missing package name or import path typo. Do **not** proceed to Task 7 until this succeeds.

- [ ] **Step 2: Verify activation script ran**

```bash
ls -la ~/.claude/plugins/marketplaces/claude-plugins-official/plugins/ralph-loop/hooks/stop-hook.sh
```

Expected: `-rwxr-xr-x` (executable bit set)

---

## Task 7: Delete old module directories

Only run this after Task 6 succeeds (rebuild confirmed working).

**Files:**
- Delete: `nixos/home/code/`
- Delete: `nixos/home/programs/`
- Delete: `nixos/home/shell/`

- [ ] **Step 1: Remove old directories**

```bash
rm -rf ~/dotfiles/nixos/home/code ~/dotfiles/nixos/home/programs ~/dotfiles/nixos/home/shell
```

- [ ] **Step 2: Verify nothing is left**

```bash
ls ~/dotfiles/nixos/home/
```

Expected output:
```
activation.nix  core.nix  dev.nix  shell.nix  tools.nix
```

- [ ] **Step 3: Commit**

```bash
cd ~/dotfiles && git add -A nixos/home/
git commit -m "refactor: remove old granular home module directories"
```

---

## Task 8: Fix `zsh/.zshenv`

**Files:**
- Modify: `zsh/.zshenv`

- [ ] **Step 1: Replace the file with clean content**

Full file contents (replace everything currently in it):

```zsh
# Source Home Manager session vars (provides LD_LIBRARY_PATH etc.)
[ -f ~/.nix-profile/etc/profile.d/hm-session-vars.sh ] && \
  source ~/.nix-profile/etc/profile.d/hm-session-vars.sh

# Databricks
export DATABRICKS_RUNTIME_VERSION="connect"

# uv
export PATH="/home/boc/.local/bin:$PATH"
```

- [ ] **Step 2: Commit**

```bash
cd ~/dotfiles && git add zsh/.zshenv
git commit -m "fix: source HM session vars in .zshenv, add DATABRICKS_RUNTIME_VERSION, strip macOS paths"
```

---

## Task 9: Fix `zsh/.zshrc`

**Files:**
- Modify: `zsh/.zshrc`

- [ ] **Step 1: Remove the Java block**

Find and delete these lines:
```zsh
#Java
export JAVA_HOME="/Library/Java/JavaVirtualMachines/sapmachine-25.jdk/Contents/Home"
```

- [ ] **Step 2: Remove the NVM block**

Find and delete these lines:
```zsh
# NVM
export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
```

Leave all other content (zinit, plugins, history, fzf, sesh, starship, zoxide, GPG) untouched.

- [ ] **Step 3: Commit**

```bash
cd ~/dotfiles && git add zsh/.zshrc
git commit -m "fix: remove macOS Java and NVM blocks from .zshrc"
```

---

## Task 10: Verify end-to-end

- [ ] **Step 1: Re-stow zsh dotfiles so symlinks point to updated files**

```bash
cd ~/dotfiles && stow -R zsh
```

Expected: no errors (or `LINK: .zshenv -> ...` if not yet linked)

- [ ] **Step 2: Open a new shell and verify env vars**

```bash
zsh -i -c 'echo "LD: $LD_LIBRARY_PATH" && echo "DBX: $DATABRICKS_RUNTIME_VERSION"'
```

Expected:
```
LD: /nix/store/<hash>-gcc-<ver>/lib:
DBX: connect
```

- [ ] **Step 3: Verify Databricks Connect works**

```bash
cd ~/edm_core && poetry run python -m rimesedm.main
```

Expected: connects to Databricks serverless, runs SQL statements, no import or library errors.

- [ ] **Step 4: Verify hook permission persists after another rebuild**

```bash
cd ~/dotfiles/nixos && sudo nixos-rebuild switch --flake .#wsl
ls -la ~/.claude/plugins/marketplaces/claude-plugins-official/plugins/ralph-loop/hooks/stop-hook.sh
```

Expected: still `-rwxr-xr-x`
