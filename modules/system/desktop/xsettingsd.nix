{ ... }: {
  flake.nixosModules.xsettingsd = { config, pkgs, ... }: {
    environment.systemPackages = [pkgs.xsettingsd];

    environment.etc."xdg/xsettingsd/xsettingsd.conf".text = ''
      Net/ThemeName "${config.dotfiles.gtkTheme}"
      Net/IconThemeName "${config.dotfiles.iconTheme}"
      Gtk/CursorThemeName "${config.dotfiles.cursor.theme}"
      Gtk/CursorThemeSize 24
      Gtk/FontName "Noto Sans 10"
      Gtk/EnableAnimations 1
      Gtk/DecorationLayout "icon:minimize,maximize,close"
      Gtk/PrimaryButtonWarpsSlider 1
      Gtk/ToolbarStyle 3
      Gtk/MenuImages 1
      Gtk/ButtonImages 1
      Gtk/SoundThemeName "ocean"
      Net/CursorBlink 1
      Net/CursorBlinkTime 1000
      Gdk/UnscaledDPI 98304
      Gdk/WindowScalingFactor 1
      Xft/DPI 98304
    '';

    systemd.user.services.xsettingsd = {
      description = "xsettingsd";
      partOf = ["graphical-session.target"];
      wantedBy = ["graphical-session.target"];

      # Only meaningful when an X server / XWayland is present.
      unitConfig.ConditionEnvironment = "DISPLAY";

      serviceConfig = {
        ExecStart = "${pkgs.xsettingsd}/bin/xsettingsd -c /etc/xdg/xsettingsd/xsettingsd.conf";
        Restart = "on-failure";
      };
    };
  };
}
