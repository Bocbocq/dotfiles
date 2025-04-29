{ pkgs, config, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    mkalias
    alacritty
    arc-browser
    nixd
    nil
    zsh
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  #nix.nixPath = [ "nixpkgs=${pkgs.path}" ];

  system.defaults = {
    dock.autohide = true;
    menuExtraClock.ShowSeconds = true;

    finder = {
      ShowStatusBar = true;
      FXPreferredViewStyle = "clmv";
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      ShowPathbar = true;
    };

    NSGlobalDomain = {
      _HIHideMenuBar = false;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
    };
    controlcenter.BatteryShowPercentage = true;
  };

  users.users= {
    anthonybocquet = {
      name = "anthonybocquet";
      home = "/Users/anthonybocquet";
    };
  };

  system.stateVersion = 6;
}
