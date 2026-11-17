{...}: {
  flake.nixosModules.xsettingsd = {
    config,
    pkgs,
    ...
  }: {
    environment.systemPackages = [pkgs.xsettingsd];

    environment.etc."xdg/xsettingsd/xsettingsd.conf".text = ''
      Net/ThemeName "catppuccin-mocha-mauve-compact+rimless"
      Net/IconThemeName "Papirus"
      Gtk/CursorThemeName "Bibata-Modern-Ice"
      Gtk/CursorThemeSize 24
      Gtk/FontName "Maple Mono NF 10"
      Gtk/EnableAnimations 1
      Gtk/DecorationLayout "icon:minimize,maximize,close"
      Gtk/PrimaryButtonWarpsSlider 1
      Gtk/ToolbarStyle 3
      Gtk/MenuImages 1
      Gtk/ButtonImages 1
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

      unitConfig.ConditionEnvironment = "DISPLAY";

      serviceConfig = {
        ExecStart = "${pkgs.xsettingsd}/bin/xsettingsd -c /etc/xdg/xsettingsd/xsettingsd.conf";
        Restart = "on-failure";
      };
    };
  };
}
