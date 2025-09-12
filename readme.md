# This is my Nix repository

sudo darwin-rebuild switch --flake ./#boc

# Stow dotfiles:
```bash
cd /Users/anthonybocquet/perso/nix/dotfiles
stow -t ~ */
```