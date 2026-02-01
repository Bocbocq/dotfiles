{
  pkgs,
  username,
  ...
}: {
  home.packages = with pkgs; [
    zsh
    oh-my-posh
    starship

    tmux
    tmuxinator
    sesh
    gum
  ];
}
