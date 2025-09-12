{ ... }:

{
  homebrew = {
    enable = true;

    # No additional taps needed currently
    taps = [];

    # CLI tools and utilities
    brews = [
      # Python development
      "poetry"
      "python@3.12"
      
      # Database tools
      "flyway"
      
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
