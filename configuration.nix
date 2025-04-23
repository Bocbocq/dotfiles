{ pkgs, config, ... }:

{
  imports = [
    ./modules/system.nix
    ./modules/brew.nix
    ./modules/stylix.nix
    ./modules/sketchybar.nix
  ];
}
