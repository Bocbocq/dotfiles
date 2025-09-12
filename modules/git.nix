{ ... }:

{
  # Git configuration using environment variables and global gitconfig
  environment.etc."gitconfig".text = ''
    [user]
      email = anthony.bocquet@sap.com
      name = I539938

    [includeIf "gitdir:~/perso/"]
      path = ~/.gitconfig-perso
  '';

  environment.etc."gitconfig-perso".text = ''
    [user]
      email = anbocque@gmail.com
      name = Bocbocq
  '';
}