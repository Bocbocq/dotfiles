# Bocbocq's Nix Configuration# This is my Nix repository



A clean and modular Nix Darwin configuration for macOS.sudo darwin-rebuild switch --flake ./#boc



## Structure# Stow dotfiles:

```bash

```cd /Users/anthonybocquet/perso/nix/dotfiles

├── flake.nix              # Main flake configurationstow -t ~ */

├── configuration.nix      # Main system configuration (imports modules)```
├── modules/               # Modular configuration files
│   ├── system.nix         # Core system settings and defaults
│   ├── packages.nix       # System-wide packages
│   ├── users.nix          # User account configuration
│   ├── git.nix           # Git configuration
│   └── brew.nix          # Homebrew packages and casks
└── dotfiles/             # User dotfiles managed with GNU Stow
    ├── ghostty/          # Ghostty terminal configuration
    └── zsh/              # Zsh shell configuration
```

## Usage

### Apply system configuration
```bash
sudo darwin-rebuild switch --flake ./#boc
```

### Manage dotfiles with Stow
```bash
cd /Users/anthonybocquet/perso/nix/dotfiles
stow -t ~ */
```

### Update flake inputs
```bash
nix flake update
```

## Features

- **Modular configuration**: Each aspect is separated into focused modules
- **Homebrew integration**: Automated package and cask management
- **Dotfiles with Stow**: Simple symlink management for user configurations
- **macOS optimizations**: Sensible system defaults for productivity
- **Git configuration**: Multi-identity setup for work and personal projects