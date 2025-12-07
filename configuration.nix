{ ... }:

{
  imports = [
    ./modules/system.nix
    ./modules/packages.nix
    ./modules/users.nix
    ./modules/brew.nix
  ];
}
