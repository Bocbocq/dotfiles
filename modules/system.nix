{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    nixd
    nil
    zsh
    uv
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  # Set primary user for nix-darwin (required for homebrew and system defaults)
  system.primaryUser = "anthonybocquet";

  users.users= {
    anthonybocquet = {
      name = "anthonybocquet";
      home = "/Users/anthonybocquet";
    };
  };

  system.stateVersion = 6;
}
