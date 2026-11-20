{...}: {
  flake.nixosModules.qt = {
    config,
    pkgs,
    ...
  }: {
    qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = "kvantum";
    };

    environment = {
      sessionVariables = {
        QT_QPA_PLATFORMTHEME = "qt5ct";
        QT_STYLE_OVERRIDE = "kvantum";
      };

      pathsToLink = [
        "/share/Kvantum"
        "/share/qt5ct"
        "/share/qt6ct"
      ];

      etc = {
        "xdg/Kvantum/kvantum.kvconfig".text = ''
          [General]
          theme=catppuccin-mocha-mauve
        '';

        "xdg/qt6ct/qt6ct.conf".text = ''
          [Appearance]
          color_scheme_path=${pkgs.catppuccin-qt5ct}/share/qt6ct/colors/catppuccin-mocha-mauve.conf
          custom_palette=true
          icon_theme=Papirus
          standard_dialogs=default
          style=kvantum

          [Fonts]
          fixed="Monospace,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
          general="Maple Mono NF,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
        '';

        "xdg/qt5ct/qt5ct.conf".text = ''
          [Appearance]
          color_scheme_path=${pkgs.catppuccin-qt5ct}/share/qt5ct/colors/catppuccin-mocha-mauve.conf
          custom_palette=true
          icon_theme=Papirus
          standard_dialogs=default
          style=kvantum

          [Fonts]
          fixed="Monospace,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
          general="Maple Mono NF,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
        '';
      };
    };

    environment.systemPackages = with pkgs; [
      (catppuccin-kvantum.override {
        variant = "mocha";
        accent = "mauve";
      })
      catppuccin-qt5ct
    ];

    systemd.tmpfiles.rules = let
      home = config.dotfiles.homeDirectory;
      user = config.dotfiles.username;
    in [
      "d ${home}/.config/Kvantum 0755 ${user} users -"
      "L+ ${home}/.config/Kvantum/kvantum.kvconfig - - - - /etc/xdg/Kvantum/kvantum.kvconfig"
      "L+ ${home}/.config/qt6ct/qt6ct.conf - - - - /etc/xdg/qt6ct/qt6ct.conf"
      "L+ ${home}/.config/qt5ct/qt5ct.conf - - - - /etc/xdg/qt5ct/qt5ct.conf"
    ];
  };
}
