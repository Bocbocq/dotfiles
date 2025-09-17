{ pkgs, ... }:

{
  # Core system packages that should be available system-wide
  environment.systemPackages = with pkgs; [
    # Power user
    neovim

    # Version control
    git
    
    # Terminal multiplexer
    tmux
    
    # Nix language servers for development
    nixd  # Nix language server
    nil   # Another Nix language server
    
    # Shell
    zsh
    starship
    fzf
    zsh-fzf-tab
    oh-my-zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    
    # Python
    uv
    ruff
    pyright
    copier
  ];
}