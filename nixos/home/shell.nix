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
  # gcc.cc.lib is also declared in tools.nix; the store path is independent
  # of that — Nix resolves it correctly regardless. Both files are always
  # imported together so runtime behaviour is consistent.
  home.sessionVariables = {
    LD_LIBRARY_PATH = "${pkgs.gcc.cc.lib}/lib:$LD_LIBRARY_PATH";
    JAVA_HOME = "${pkgs.jdk17}";
  };
}
