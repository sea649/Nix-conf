{...}: {
  flake.nixosModules.gtk = {
    pkgs,
    config,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      (catppuccin-gtk.override {
        accents = ["mauve"];
        size = "compact";
        tweaks = ["rimless"];
        variant = "mocha";
      })
      (catppuccin-papirus-folders.override {
        accent = "mauve";
      })
      bibata-cursors
    ];

    gtk.iconCache.enable = true;

    environment = {
      sessionVariables = {
        XCURSOR_THEME = "Bibata-Modern-Ice";
        XCURSOR_SIZE = "24";
      };
      variables = {
        XCURSOR_THEME = "Bibata-Modern-Ice";
        XCURSOR_SIZE = "24";
      };
    };
    programs.dconf = {
      enable = true;
      profiles.user.databases = [
        {
          lockAll = false;
          settings = {
            "org/gnome/desktop/interface" = {
              gtk-theme = "catppuccin-mocha-mauve-compact+rimless";
              icon-theme = "Papirus";
              color-scheme = "prefer-dark";
              cursor-theme = "Bibata-Modern-Ice";
              font-name = "Maple Mono NF 10";
              monospace-font-name = "Maple Mono NF 10";
            };
          };
        }
      ];
    };
  };
}
