{ ... }: {
  flake.nixosModules.greeter = { config, ... }: {
    services.displayManager.noctalia-greeter = {
      enable = true;
      passwordlessSyncUsers = [config.dotfiles.username];

      cursorTheme = {
        package = config.dotfiles.cursor.package;
        name = config.dotfiles.cursor.theme;
      };

      settings = {
        session.default = "Umbriel";
        user.default = config.dotfiles.username;

        appearance = {
          scheme = "Synced";
          theme_mode = "dark";
        };

        keyboard.layout = config.dotfiles.keyboardLayout;
        output.name = config.dotfiles.shellMonitor;
        cursor.size = 24;
      };
    };

    # Unlock the login keyring at greeter login.
    security.pam.services.greetd.enableGnomeKeyring = true;
  };
}
