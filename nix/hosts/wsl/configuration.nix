# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, username, ... }:

{
  imports = [ ];

  wsl.enable = true;
  wsl.defaultUser = username;

  # Enable nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [ git vim wget ];

  # Set the default editor to vim
  environment.variables.EDITOR = "vim";

  programs.zsh.enable = true;
  users.users.${username}.shell = pkgs.zsh;
}
