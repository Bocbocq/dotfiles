{
  description = "Bocbocq nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, mac-app-util, nix-homebrew, ... }: {
    darwinConfigurations."boc" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      specialArgs = { inherit inputs; };
      
      modules = [
        ./configuration.nix

        mac-app-util.darwinModules.default
        nix-homebrew.darwinModules.nix-homebrew

        {
          # Homebrew configuration
          nix-homebrew = {
            enable = true;
            user = "anthonybocquet";
            enableRosetta = true;
            autoMigrate = true;
          };

          system.configurationRevision = self.rev or self.dirtyRev or null;
          security.pam.services.sudo_local.touchIdAuth = true;
        }
      ];
    };
  };
}
