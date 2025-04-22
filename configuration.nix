{ pkgs, config, ... }:

{
  imports = [
    ./modules/system.nix
    ./modules/home.nix
    ./modules/brew.nix
    ./modules/stylix.nix
  ];
}
