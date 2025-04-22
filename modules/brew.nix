{ pkgs, config, ... }:

{
  homebrew = {
    enable = true;

    brews = [
      "ca-certificates"
      "poetry"
      "python@3.9"
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
