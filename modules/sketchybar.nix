{ pkgs, config, ... }:

{
  sketchybar.enable = true;
  sketchybar.config = ''
        sketchybar --bar height=24
        sketchybar --update
        echo "sketchybar configuration loaded.."
      '';
}