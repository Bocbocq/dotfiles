{
  description = "Bocbocq nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";


    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    stylix.url = "github:danth/stylix";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, mac-app-util, nix-homebrew, stylix, home-manager, agenix, ... }: {
    darwinConfigurations."boc" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      specialArgs = { inherit inputs;};
      
      modules = [
        ./configuration.nix
        ./home_manager.nix

        mac-app-util.darwinModules.default
        nix-homebrew.darwinModules.nix-homebrew
        stylix.darwinModules.stylix

        {
          nix-homebrew = {
            enable = true;
            user = "anthonybocquet";
            enableRosetta = true;
            autoMigrate = true;
          };

          system.configurationRevision = self.rev or self.dirtyRev or null;
          security.pam.services.sudo_local.touchIdAuth = true;
        }
        {
          environment.systemPackages = [ agenix.packages.aarch64-darwin.default ];
        }
      ];
    };
  };
}
