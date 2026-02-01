{ pkgs, ... }: {
  home.packages = with pkgs; [ lazygit delta ];

  programs.git = {
    enable = true;
    userName = "Bocbocq";
    userEmail = "anbocque@gmail.com";
  };
}
