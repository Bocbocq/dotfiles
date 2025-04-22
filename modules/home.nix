{ pkgs, config, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.anthonybocquet = {
    home.stateVersion = "23.11"; # adjust as needed

    programs.git.enable = true;
    # Add more home-manager config here
  };
}
