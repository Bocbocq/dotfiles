{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixd

    alejandra

    statix # Pour détecter les anti-patterns dans ton code Nix
    deadnix # Pour trouver le code inutilisé
  ];
}
