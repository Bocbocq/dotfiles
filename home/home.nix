{pkgs, ...}: {

  imports = [
    ./git.nix
    ./zsh.nix
    ./starship.nix
  ];

  programs.home-manager.enable = true;

  home = {
    homeDirectory = "/Users/anthonybocquet";
    stateVersion = "24.11";
    packages = with pkgs; [
      zsh
      zsh-autosuggestions
      zsh-completions
      zsh-syntax-highlighting
      zsh-you-should-use
      starship
    ];
  };
}