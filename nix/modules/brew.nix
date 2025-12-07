{ ... }:

{
  homebrew = {
    enable = true;

    taps = [
      "databricks/tap"
      "cloudfoundry/tap"
    ];

    brews = [
      "cowsay"
      "fortune"
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

    casks = [
      "sapmachine25-jdk"
      "bruno"
      "ghostty"
      "font-jetbrains-mono-nerd-font"
      "arc"
    ];

    onActivation.autoUpdate = false;
  };
}
