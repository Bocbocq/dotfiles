{ pkgs, config, ... }:

{
  homebrew = {
    enable = true;

    taps = [
      "FelixKratz/formulae"
    ];

    brews = [
      "ca-certificates"
      "poetry"
      "python@3.9"
      "sketchybar"
    ];

    casks = [
      "sapmachine11-jdk"
      "zen-browser"
    ];

    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
  };
}
