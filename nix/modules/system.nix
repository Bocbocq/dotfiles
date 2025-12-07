{ ... }:

{
  # Nix configuration
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Environment variables
  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/var/lib";
    XDG_CACHE_HOME  = "$HOME/var/cache";
  };

  # macOS system defaults
  system.defaults = {
    dock.autohide = true;

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

  system.stateVersion = 6;
}
