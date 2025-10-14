{ ... }:

{
  homebrew = {
    enable = true;

    # No additional taps needed currently
    taps = [

      "databricks/tap"

    ];

    # CLI tools and utilities
    brews = [
      # Fun utilities
      "cowsay"
      "fortune"
      
      # Dotfile management
      "stow"

      "tree-sitter-cli"

      "databricks"
      "gnupg"
    ];

    # GUI applications
    casks = [
      # Development
      "sapmachine17-jdk"
      
      # Terminal
      "ghostty"
      
      # Browser
      "arc"
    ];

    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
  };
}
