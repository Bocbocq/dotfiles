{ pkgs, ... }:

{
  imports = [
    ./modules/brew.nix
    ./modules/packages.nix
    ./modules/users.nix
    ./modules/system.nix
  ];

  # Nix configuration
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
      NSGlobalDomain.AppleShowAllExtensions = true;
      controlcenter.BatteryShowPercentage = true;
    };
  };

  # User
  users.users.anthonybocquet = {
    name = "anthonybocquet";
    home = "/Users/anthonybocquet";
  };
}
