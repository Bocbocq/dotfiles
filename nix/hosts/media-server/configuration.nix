# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, username, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = [ /etc/nixos/hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "24.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [ git vim wget docker ];

  environment.variables.EDITOR = "vim";

  programs.zsh.enable = true;

  users.users.${username} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    group = "users";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
  };

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  services.openssh.enable = true;
  virtualisation.docker.enable = true;

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  boot.initrd.kernelModules = [ "i915" ];

  hardware.firmware = with pkgs; [ linux-firmware ];

  boot.kernelModules = [ "i915" ];
  boot.kernelParams =
    [ "i915.enable_guc=3" "i915.fastboot=1" "i915.force_probe=46d4" ];

  hardware.opengl.enable = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva
      libva-utils
      intel-media-driver # Modern Intel VAAPI / QSV driver
      intel-compute-runtime # OpenCL support (tone mapping, etc)
      ocl-icd # OpenCL ICD loader
      intel-gpu-tools # GPU monitoring tools
    ];
  };

  networking.useDHCP = false;
  networking.interfaces.enp1s0 = {
    useDHCP = false;
    ipv4.addresses = [{
      address = "192.168.1.26";
      prefixLength = 24;
    }];
  };
  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
}

