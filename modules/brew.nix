{ ... }:

{
  homebrew = {
    enable = true;

    # No additional taps needed currently
    taps = [];

    # CLI tools and utilities
    brews = [
      
      # Fun utilities
      "cowsay"
      "fortune"
      
      # Dotfile management
      "stow"
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
