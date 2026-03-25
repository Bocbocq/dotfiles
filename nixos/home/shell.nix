{pkgs, ...}: {
  home.packages = with pkgs; [
    zsh
    oh-my-posh
    starship
    tmux
    tmuxinator
    sesh
    gum
    ghostty
  ];
  home.sessionVariables = {
    LD_LIBRARY_PATH = "${pkgs.gcc.cc.lib}/lib:$LD_LIBRARY_PATH";
  };
}
