{pkgs, ...}: {
  home.packages = with pkgs; [
    lazygit
    delta
    github-cli
  ];
}
