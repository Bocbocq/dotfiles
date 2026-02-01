{pkgs, ...}: {
  home.packages = with pkgs; [
    # Dotfiles
    stow

    # Utils
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
  ];
}
