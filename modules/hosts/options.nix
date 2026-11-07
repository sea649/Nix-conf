{ ... }: {
  flake.nixosModules.options =
    { lib, pkgs, ... }:
    let
      kernels = [
        "normal"
        "zen"
        "jovian"
      ];
      shells = [ "noctalia" ];
      browser = [
        "helium"
        "librewolf"
      ];
      wallpaper = [
        "black-hole.png"
        "cat-vibin.png"
        "HollowKnight.png"
        "novari.png"
        "panes.jpg"
        "train-sideview.png"
        "wallhaven-6dygpl.jpg"
        "wallhaven-ducks-flowers.png"
        "wallhaven-je8p85_1920x1200.png"
        "wallhaven-mountain-town.png"
        "wallhaven-rq6yqm_1920x1200.png"
        "wallhaven-x6x3gz_1920x1200.png"
        "wallhaven-zyxvqy.jpg"
      ];
      keyboardLayouts = [
        "gb"
        "us"
        "de"
        "fr"
        "jp"
      ];
      gtkThemes = [
        "Adwaita-dark"
        "Colloid-dark"
        "Orchis-dark"
        "Breeze-Dark"
      ];
      iconThemes = [
        "Papirus-Dark"
        "Candy"
        "WhiteSur"
        "Tela"
        "Kora"
        "breeze-dark"
      ];
    in
    {
      options.dotfiles = {
        username = lib.mkOption {
          type = lib.types.str;
          description = "Primary user account name.";
          default = "sea";
        };
        email = lib.mkOption {
          type = lib.types.str;
          description = "Primary user account email.";
          default = " ";
        };
        hostname = lib.mkOption {
          type = lib.types.str;
          description = "Machine name.";
          default = "workstation";
        };
        homeDirectory = lib.mkOption {
          type = lib.types.str;
          description = "Home directory of the primary user.";
          default = "/home/sea";
        };
        version = lib.mkOption {
          type = lib.types.str;
          description = "system state version";
          default = "26.11";
        };
        system = lib.mkOption {
          type = lib.types.str;
          description = "System architecture for this host, e.g. \"x86_64-linux\".";
          default = "x86_64-linux";
        };
        repoPath = lib.mkOption {
          type = lib.types.str;
          description = "Absolute path to this dotfiles checkout on the host.";
          default = "/home/sea/Nix-conf";
        };
        umbrielConfig = lib.mkOption {
          type = lib.types.nullOr lib.types.path;
          description = "Host-specific Umbriel TOML config;";
          default = null;
        };
        noctaliaConfig = lib.mkOption {
          type = lib.types.nullOr lib.types.path;
          description = "Host-specific Noctalia TOML config;";
          default = null;
        };
        timezone = lib.mkOption {
          type = lib.types.str;
          description = "IANA time zone, e.g. \"Europe/London\".";
          default = "Europe/London";
        };
        locale = lib.mkOption {
          type = lib.types.str;
          description = "Default locale, e.g. \"en_GB.UTF-8\".";
          default = "en_GB.UTF-8";
        };
        keyboardLayout = lib.mkOption {
          type = lib.types.enum keyboardLayouts;
          description = "XKB keyboard layout.";
          default = "gb";
        };
        consoleKeyMap = lib.mkOption {
          type = lib.types.str;
          description = "Console keymap for loadkeys. XKB names differ, e.g. gb -> uk.";
          default = "uk";
        };
        shell = lib.mkOption {
          type = lib.types.enum shells;
          description = "Desktop shell.";
          default = "noctalia";
        };
        shellMonitor = lib.mkOption {
          type = lib.types.str;
          description = "Primary output the shell/bar renders on.";
          default = "eDP-1";
        };
        wallpaper = lib.mkOption {
          type = lib.types.enum wallpaper;
          description = "Wallpaper to use";
          default = "wallhaven-je8p85_1920x1200.png";
        };
        kernel = lib.mkOption {
          type = lib.types.enum kernels;
          description = "Kernel flavour: normal (latest), zen, jovian.";
          default = "normal";
        };
        browser = lib.mkOption {
          type = lib.types.enum browser;
          description = "Main browser.";
          default = "helium";
        };
        gtkTheme = lib.mkOption {
          type = lib.types.enum gtkThemes;
          description = "GTK theme name.";
          default = "Adwaita-dark";
        };
        iconTheme = lib.mkOption {
          type = lib.types.enum iconThemes;
          description = "Icon theme name.";
          default = "breeze-dark";
        };
        cursor = {
          theme = lib.mkOption {
            type = lib.types.str;
            default = "Bibata-Modern-Ice";
          };

          package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.bibata-cursors;
          };

          size = lib.mkOption {
            type = lib.types.int;
            default = 24;
          };
        };
      };
    };
}
