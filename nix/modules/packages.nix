{ pkgs, ... }:

{
  # Core system packages that should be available system-wide
  environment.systemPackages = with pkgs; [
    # Power user
    neovim
    gum
    # Version control
    git
    lazygit
    delta
    # Terminal multiplexer
    sesh
    
    zigpkgs.master

    # Nix language servers for development
    nixd  # Nix language server
    
    # Shell
    zsh
    starship
    fzf
    zsh-fzf-tab
    oh-my-zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    ripgrep
    fd
    zoxide
    bat
    wget

    # Python
    uv
    ruff
    pyright
    copier

    # Others
    maven
  ];
}
