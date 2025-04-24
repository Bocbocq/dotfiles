{ pkgs, config, ... }:

{
  homebrew = {
    enable = true;

    taps = [
    ];

    brews = [
      "ca-certificates"
      "poetry"
      "python@3.9"
    ];

    casks = [
      "sapmachine11-jdk"
    ];

    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
  };
}
