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

  security.pam.services.sudo_local.touchIdAuth = true;

  programs.zsh.enable = true;

  system.defaults = {
    dock.autohide = true;
    finder.FXPreferredViewStyle = "clmv";
  };

  system.stateVersion = 6;
}
