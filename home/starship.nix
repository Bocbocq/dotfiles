{
  programs.starship = {
    enable = true;
    enableZshIntegration = true; # or true for bash/fish/etc.
    settings = {
      # General settings
      add_newline = true;
      palette = "nord";

      # Example modules with Nord colors
      format = ''
      $directory$git_branch$git_status$nodejs$rust$golang$python$character
      '';

      directory = {
        style = "nord8";
      };

      git_branch = {
        symbol = "🌿 ";
        style = "nord7";
      };

      git_status = {
        style = "nord11";
      };

      character = {
        success_symbol = "[➜](nord14)";
        error_symbol = "[✗](nord11)";
      };

      palettes.nord = {
        # Nord color palette
        nord0 = "#2E3440"; # background
        nord1 = "#3B4252"; # focused UI element / not for syntax highlighting
        nord2 = "#434C5E"; # selection
        nord3 = "#4C566A"; # comments
        nord4 = "#D8DEE9"; # base text color
        nord5 = "#E5E9F0"; # highlight text
        nord6 = "#ECEFF4"; # highlight text
        nord7 = "#8FBCBB"; # Primary accent color
        nord8 = "#88C0D0"; # primary UI / most attention 
        nord9 = "#81A1C1"; # Secondary UI / reserved keywords / punctuation
        nord10 = "#5E81AC"; # Tertiary UI
        nord11 = "#BF616A"; # error / deletion
        nord12 = "#D08770"; # decorator / dangerous / advanced
        nord13 = "#EBCB8B"; # warning
        nord14 = "#A3BE8C"; # success
        nord15 = "#B48EAD"; # uncommon / numbers
      };
    };
  };
}
