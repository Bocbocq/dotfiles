{pkgs, ...}:
{
  environment.pathsToLink = [ "/share/zsh" ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    completionInit = "autoload -Uz compinit && compinit";
    autosuggestion = {
      enable = true;
      strategy = [
        "history"
        "completion"
      ];
    };

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    history.size = 10000;

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
      }
      {
        name = "zsh-completions";
        src = "${pkgs.zsh-completions}/share/zsh-completions";
      }
      {
        name = "zsh-syntax-highlighting";
        src = "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting";
      }
      {
        name = "zsh-you-should-use";
        src = "${pkgs.zsh-you-should-use}/share/zsh-you-should-use";
      }
    ];

    oh-my-zsh = {
      enable = false;
    };
  };



}