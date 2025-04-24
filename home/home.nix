{pkgs, ...}: {

  imports = [
    ./git.nix
  ];

  programs.home-manager.enable = true;

  home = {
    homeDirectory = "/Users/anthonybocquet";
    stateVersion = "24.11";
    packages = with pkgs; [
      zsh
    ];
  };
}