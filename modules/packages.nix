{ pkgs, ... }:

{
  # Core system packages that should be available system-wide
  environment.systemPackages = with pkgs; [
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
    
    # Python package manager
    uv
    ruff
    pyright
    copier
  ];
}