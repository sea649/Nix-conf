{ ... }: {
  flake.nixosModules.setup = { config, ... }: {
    nixpkgs.hostPlatform = config.dotfiles.system;
    time.timeZone = config.dotfiles.timezone;
    i18n.defaultLocale = config.dotfiles.locale;
    i18n.extraLocaleSettings = {
      LC_ADDRESS = config.dotfiles.locale;
      LC_IDENTIFICATION = config.dotfiles.locale;
      LC_MEASUREMENT = config.dotfiles.locale;
      LC_MONETARY = config.dotfiles.locale;
      LC_NAME = config.dotfiles.locale;
      LC_NUMERIC = config.dotfiles.locale;
      LC_PAPER = config.dotfiles.locale;
      LC_TELEPHONE = config.dotfiles.locale;
      LC_TIME = config.dotfiles.locale;
    };
    console.keyMap = config.dotfiles.consoleKeyMap;
    system.stateVersion = config.dotfiles.version;
    networking.hostName = config.dotfiles.hostname;
  };
}
