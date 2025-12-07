{ pkgs, ... }:

{
  imports = [
    ./modules/brew.nix
    ./modules/packages.nix
    ./modules/users.nix
  ];

  # Nix configuration
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Environment variables
  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/var/lib";
    XDG_CACHE_HOME = "$HOME/var/cache";
  };

  # macOS defaults
  system = {
    stateVersion = 6;
    defaults = {
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

  };

  security.pam.services.sudo_local.touchIdAuth = true;
  # User
  users.users.anthonybocquet = {
    name = "anthonybocquet";
    home = "/Users/anthonybocquet";
  };
}
