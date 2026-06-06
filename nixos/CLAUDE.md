# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a NixOS flake-based dotfiles repository managing two hosts:
- **wsl** — NixOS running under WSL2 (primary development environment)
- **media-server** — Bare-metal NixOS with Intel GPU passthrough for media

Non-NixOS dotfiles (nvim, zsh, tmux, git, etc.) live in sibling directories and are managed with GNU Stow.

## Apply Configuration

```bash
# Rebuild and switch (from /home/boc/dotfiles/nixos)
sudo nixos-rebuild switch --flake .#wsl
sudo nixos-rebuild switch --flake .#media-server

# Update all flake inputs
nix flake update

# Apply stow dotfiles (from /home/boc/dotfiles)
stow -t ~ */
```

## Architecture

### Flake structure (`nixos/`)

```
flake.nix                    # Defines inputs and nixosConfigurations for each host
hosts/<host>/
  configuration.nix          # System-level NixOS config (packages, services, hardware)
  home.nix                   # Imports shared home/ modules for that host
home/
  core.nix                   # Home Manager bootstrap (username, stateVersion)
  code/                      # Language toolchains (lua, python, nix, rust, js, common)
  programs/                  # User programs (git, editors, docker, commons/utils)
  shell/                     # Shell environment (terminals, shells/zsh/tmux)
```

### Module pattern

`home/` modules are purely declarative `home.packages` lists (and occasional `home.sessionVariables`). No custom NixOS options or `lib.mkOption` patterns are used — just flat imports assembled in each host's `home.nix`.

The flake passes `username = "boc"` and `inputs` as `specialArgs` so any module can receive them.

### Stow dotfiles (sibling directories)

`nvim/`, `zsh/`, `tmux/`, `git/`, `ghostty/`, `starship/`, `bat/`, `lazygit/` are plain config directories symlinked into `$HOME` via `stow -t ~ */`.

## Key constraints

- `nixpkgs` tracks `nixos-unstable`; `home-manager` tracks `master` — breaking changes can appear without warning.
- `nixpkgs.config.allowUnfree = true` is set on both hosts.
- The WSL host uses `nix-ld` with `stdenv.cc.cc.lib` to support dynamically-linked binaries.
