{pkgs, ...}: {
  home.packages = with pkgs; [
    # Git
    lazygit
    delta
    github-cli

    # CLI utils
    stow
    bat
    dua
    entr
    eza
    fd
    fzf
    gcc
    gnumake
    ripgrep
    unzip
    zoxide
    zip
    btop
    tree-sitter
    bash-language-server
    databricks-cli

    # Docker
    docker
    lazydocker

    # Editor
    neovim-unwrapped
  ];
}
