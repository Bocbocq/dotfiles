{ ... }:

{
  imports = [
    ./modules/system.nix
    ./modules/packages.nix
    ./modules/users.nix
    ./modules/git.nix
    ./modules/brew.nix
  ];
}
