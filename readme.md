# This is my Nix repository

darwin-rebuild switch --flake ./#boc

# Stow dotfiles:
```bash
cd /Users/anthonybocquet/perso/nix/dotfiles
stow -t ~ */
```