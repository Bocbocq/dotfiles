# Bocbocq's dotfiles

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

