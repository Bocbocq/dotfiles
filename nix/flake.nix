{
  description = "Boc's NixOS Configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, ... }@inputs:
    let
      username = "boc";
      system = "x86_64-linux";

      specialArgs = { inherit inputs username; };

      mkHomeManagerModule = homeFile: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = specialArgs;
        home-manager.users.${username} = import homeFile;
      };

    in {
      nixosConfigurations = {
        "media-server" = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ./hosts/media-server/configuration.nix

            home-manager.nixosModules.home-manager
            (mkHomeManagerModule ./hosts/media-server/home.nix)
          ];
        };

        "wsl" = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            nixos-wsl.nixosModules.wsl

            ./hosts/wsl/configuration.nix

            home-manager.nixosModules.home-manager
            (mkHomeManagerModule ./hosts/wsl/home.nix)
          ];
        };
      };
    };
}
