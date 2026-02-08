# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  config,
  lib,
  pkgs,
  username,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  imports = [./hardware-configuration.nix];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "24.11";

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["root" "boc"];

  environment.systemPackages = with pkgs; [git vim wget docker];

  environment.variables.EDITOR = "vim";

  programs.zsh.enable = true;

  users.users.${username} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    group = "users";
    extraGroups = ["wheel" "networkmanager" "docker"];
  };

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  services.openssh.enable = true;
  virtualisation.docker.enable = true;

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  boot.initrd.kernelModules = ["i915"];

  hardware.firmware = with pkgs; [linux-firmware];

  boot.kernelModules = ["i915"];
  boot.kernelParams = ["i915.enable_guc=3" "i915.fastboot=1" "i915.force_probe=46d4"];

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

  networking.useDHCP = true;

  # Use the 'powersave' governor to keep clocks lower and heat down
  powerManagement.cpuFreqGovernor = "powersave";

  # Enable Thermald (Intel's thermal management daemon)
  services.thermald.enable = true;

  # Optional: TLP for aggressive power management
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "power";
    };
  };
}
