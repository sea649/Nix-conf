{ inputs, ... }: {
  flake.nixosModules.hjem = { config, ... }: {
    imports = [ inputs.hjem.nixosModules.default ];
    hjem.clobberByDefault = true;
    hjem.users.${config.dotfiles.username} = {
      enable = true;
      directory = config.dotfiles.homeDirectory;
    };
  };
}
