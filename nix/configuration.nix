{ pkgs, ... }:

{
  imports = [ ./modules/brew.nix ];

  # Nix configuration
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Environment
  environment = {
    variables = {
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/var/lib";
      XDG_CACHE_HOME = "$HOME/var/cache";
    };

    systemPackages = with pkgs; [
      neovim git lazygit delta gum
      zsh starship fzf zsh-fzf-tab oh-my-zsh 
      zsh-autosuggestions zsh-syntax-highlighting zsh-completions
      ripgrep fd zoxide bat wget
      sesh zigpkgs.master nixd
      uv ruff pyright copier maven
    ];
  };

  # macOS defaults
  system = {
    stateVersion = 5;
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
