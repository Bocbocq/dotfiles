{ ... }:

{
  # Git configuration using environment variables and global gitconfig
  environment.etc."gitconfig".text = ''
    [user]
      email = anthony.bocquet@sap.com
      name = I539938

    [includeIf "gitdir:~/perso/"]
      path = ~/.gitconfig-perso

    [core]
      pager = delta

    [interactive]
      diffFilter = delta --color-only

    [delta]
      navigate = true  # use n and N to move between diff sections
      dark = true      # or light = true, or omit for auto-detection

    [merge]
      conflictStyle = zdiff3
  '';

  environment.etc."gitconfig-perso".text = ''
    [user]
      email = anbocque@gmail.com
      name = Bocbocq
    [core]
      pager = delta

    [interactive]
      diffFilter = delta --color-only

    [delta]
      navigate = true  # use n and N to move between diff sections
      dark = true      # or light = true, or omit for auto-detection

    [merge]
      conflictStyle = zdiff3

  '';
}
