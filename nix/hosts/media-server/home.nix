{ pkgs, ... }: {
  imports = [
    ../../home/core.nix
    ../../home/code
    ../../home/programs
    ../../home/shell/shells.nix
  ];

}
