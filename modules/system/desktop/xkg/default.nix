{ ... }: {
  flake.nixosModules.xkg = { config, ... }: {
      hjem.users.${config.dotfiles.username}.files = {
        ".config/mimeapps.list".source = ./mimeapps.list;
        ".config/user-dirs.dirs".source = ./user-dirs.dirs;
      };
    };
}
