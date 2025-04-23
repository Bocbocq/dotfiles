{ pkgs, config, ... }:

{
  imports = [
    ./modules/system.nix
    ./modules/brew.nix
  ];
}
