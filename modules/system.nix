{ pkgs, config, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    mkalias
    alacritty
    zsh
    arc-browser
    nixd
    sketchybar
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.nixPath = [ "nixpkgs=${pkgs.path}" ];

  programs.zsh.enable = true;

  system.defaults = {
    dock.autohide = true;
    finder.FXPreferredViewStyle = "clmv";
    NSGlobalDomain._HIHideMenuBar = true;
  };

  system.stateVersion = 6;
}
