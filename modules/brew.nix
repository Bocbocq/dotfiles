{ ... }:

{
  homebrew = {
    enable = true;

    # No additional taps needed currently
    taps = [

      "databricks/tap"
      "cloudfoundry/tap"

    ];

    # CLI tools and utilities
    brews = [
      # Fun utilities
      "cowsay"
      "fortune"
      
      # Dotfile management
      "stow"

      "tree-sitter-cli"

      "cf-cli@8"
      "databricks"
      "gnupg"
      "nvm"
      "tmux"
      "docker"
      "docker-compose"
    ];

    # GUI applications
    casks = [
      # Development
      "sapmachine25-jdk"
      "bruno"
      # Terminal
      "ghostty"
      "font-jetbrains-mono-nerd-font"
      
      # Browser
      "arc"
    ];

    onActivation = {
      autoUpdate = false;
      upgrade = false;
    };
  };
}
