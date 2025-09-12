{ ... }:

{
  homebrew = {
    enable = true;

    taps = [
    ];

    brews = [
      "poetry"
      "python@3.12"
      "flyway"
      "cowsay"
      "fortune"
      "stow"
    ];

    casks = [
      "sapmachine17-jdk"
      "ghostty"
      "arc"
    ];

    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
  };
}
