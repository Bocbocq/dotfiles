{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Rust toolchain
    cargo
    rustc
    rust-analyzer
    rustfmt
    clippy

    # Zig
    pkgs.zigpkgs.master

    # Editor and Git
    neovim
    git
    lazygit
    delta
    gum
    
    # Shell
    zsh
    starship
    fzf
    zsh-fzf-tab
    oh-my-zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    
    # CLI tools
    ripgrep
    fd
    zoxide
    bat
    wget
    sesh
    
    # Nix tools
    nixd
    statix
    nixfmt-rfc-style

    # Python
    uv
    ruff
    pyright
    copier

    # Java
    maven
  ];
}
