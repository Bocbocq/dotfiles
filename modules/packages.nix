{ pkgs, ... }:

{
  # Core system packages that should be available system-wide
  environment.systemPackages = with pkgs; [
    # Power user
    neovim

    # Version control
    git
    lazygit
    delta
    # Terminal multiplexer
    tmux
    sesh   
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
  ];
}
