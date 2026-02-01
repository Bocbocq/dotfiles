{ pkgs, username, ... }: {
  home.packages = with pkgs; [
    zsh
    oh-my-posh

    tmux
    tmuxinator
    sesh
    gum
  ];
}
