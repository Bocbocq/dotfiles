{ pkgs, config, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    mkalias
    alacritty
    zsh
    arc-browser
    nixd
    nil
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.nixPath = [ "nixpkgs=${pkgs.path}" ];

  programs.zsh.enable = true;

  system.defaults = {
    dock.autohide = true;
    finder.FXPreferredViewStyle = "clmv";
    NSGlobalDomain._HIHideMenuBar = false;
  };

  system.stateVersion = 6;
}
