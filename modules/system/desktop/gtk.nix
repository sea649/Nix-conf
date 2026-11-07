{ ... }: {
  flake.nixosModules.gtk = { pkgs, config, ... }: {
    environment.systemPackages =
      (with pkgs; [
        gnome-themes-extra
        colloid-gtk-theme
        papirus-icon-theme
        candy-icons
        whitesur-icon-theme
        tela-icon-theme
        kora-icon-theme
        kdePackages.breeze-gtk
        kdePackages.breeze-icons
      ])
      ++ [config.dotfiles.cursor.package];

    # NixOS 26.05 only has gtk.iconCache; theme/font/cursor settings live in
    # the XDG settings.ini files below (the old Home Manager gtk.* options
    # no longer exist in NixOS).
    gtk.iconCache.enable = true;

    environment.sessionVariables = {
      GTK_THEME = config.dotfiles.gtkTheme;
      XCURSOR_THEME = config.dotfiles.cursor.theme;
      XCURSOR_SIZE = "24";
    };

    environment.etc."xdg/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=${config.dotfiles.gtkTheme}
      gtk-icon-theme-name=${config.dotfiles.iconTheme}
      gtk-cursor-theme-name=${config.dotfiles.cursor.theme}
      gtk-cursor-theme-size=24
      gtk-font-name=Noto Sans 10
      gtk-application-prefer-dark-theme=true
      gtk-decoration-layout=icon:minimize,maximize,close
      gtk-enable-animations=true
      gtk-menu-images=true
      gtk-button-images=true
      gtk-primary-button-warps-slider=true
      gtk-sound-theme-name=ocean
      gtk-toolbar-style=3
      gtk-xft-dpi=98304
    '';

    environment.etc."xdg/gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=${config.dotfiles.gtkTheme}
      gtk-icon-theme-name=${config.dotfiles.iconTheme}
      gtk-cursor-theme-name=${config.dotfiles.cursor.theme}
      gtk-cursor-theme-size=24
      gtk-font-name=Noto Sans 10
      gtk-application-prefer-dark-theme=true
      gtk-decoration-layout=icon:minimize,maximize,close
      gtk-enable-animations=true
      gtk-primary-button-warps-slider=true
      gtk-sound-theme-name=ocean
      gtk-xft-dpi=98304
    '';
  };
}
