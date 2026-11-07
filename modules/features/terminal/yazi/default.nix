{ moduleWithSystem, lib, ... }: {
  flake.wrappers.yazi = { wlib, config, ... }: {
    imports = [ wlib.wrapperModules.yazi ];

    initLua = ./init.lua;

    settings = {
      yazi = lib.importTOML ./yazi.toml;
      keymap = lib.importTOML ./keymap.toml;
      theme = lib.importTOML ./theme.toml;
    };
    buildCommand.replaceVfs = {
      after = [ "constructFiles" ];
      data = ''
        rm -f ${config.generatedConfig.placeholder}/vfs.toml
        ln -s /run/agenix/vfs ${config.generatedConfig.placeholder}/vfs.toml
      '';
    };
    plugins = {
      bunny = ./plugins/bunny.yazi;
      chmod = ./plugins/chmod.yazi;
      compress = ./plugins/compress.yazi;
      diff = ./plugins/diff.yazi;
      faster-piper = ./plugins/faster-piper.yazi;
      full-border = ./plugins/full-border.yazi;
      git = ./plugins/git.yazi;
      githead = ./plugins/githead.yazi;
      jump-to-char = ./plugins/jump-to-char.yazi;
      lazygit = ./plugins/lazygit.yazi;
      smart-enter = ./plugins/smart-enter.yazi;
      smart-filter = ./plugins/smart-filter.yazi;
      smart-paste = ./plugins/smart-paste.yazi;
    };

    flavors.catppuccin-mocha = ./flavors/catppuccin-mocha.yazi;
  };

  flake.nixosModules.yazi = moduleWithSystem (
    { self', pkgs, ... }: {
      environment.systemPackages = [
        self'.packages.yazi
        pkgs.zip
      ];
    }
  );
}
