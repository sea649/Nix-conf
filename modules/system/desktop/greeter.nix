{ ... }: {
  flake.nixosModules.greeter = { config, pkgs, ... }: let
    tuigreet = pkgs.writeShellApplication {
      name = "tuigreet-start";
      runtimeInputs = [
        pkgs.tuigreet
        pkgs.systemd
      ];
      text = ''
        exec tuigreet \
          --config /etc/tuigreet/config.toml \
          --time \
          --time-format '%Y-%m-%d %H:%M' \
          --greeting 'Welcome to Umbriel' \
          --user ${config.dotfiles.username} \
          --remember \
          --remember-user-session \
          --asterisks \
          --battery \
          --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions \
          --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions \
          --theme 'border=magenta;text=white;time=magenta;container=black;title=cyan;greet=cyan;prompt=blue;input=white;action=blue;button=yellow'
      '';
    };
  in {
    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings.default_session = {
        user = "greeter";
        command = "${tuigreet}/bin/tuigreet-start";
      };
    };

    services.displayManager.defaultSession = "umbriel";

    environment.etc."tuigreet/config.toml".text = ''
      [[outputs]]
      connector = "${config.dotfiles.shellMonitor}"
      primary = true
    '';

    security.pam.services.greetd.enableGnomeKeyring = true;
  };
}
