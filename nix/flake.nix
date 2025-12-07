{
  description = "Bocbocq nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      ...
    }:
    {
      darwinConfigurations."boc" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";

        modules = [
          ./configuration.nix
          nix-homebrew.darwinModules.nix-homebrew

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
        ];
      };
    };
}
