{ inputs, config, lib, pkgs, ... }: {

  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.anthonybocquet = {
    imports = [
      ./home/home.nix
    ];
  };
}