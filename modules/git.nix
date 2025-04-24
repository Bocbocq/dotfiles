{
  programs.git.enable = true;
  
  programs.git.extraConfig = {
    user = {
      email = "anthony.bocquet@sap.com";
      name = "I539938";
    };
  };

  programs.git.includes = [
    {
      contentSuffix = "perso";
      condition = "gitdir:~/perso/";
      contents.user = {
        email = "anbocque@gmail.com";
        name = "Bocbocq";
      }
    }
  ]
}