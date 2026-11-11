{ ... }: {
  flake.nixosModules.steamdeck-options = { ... }: {
    dotfiles = {
      username = "sea";
      email = " ";
      hostname = "steamdeck";
      homeDirectory = "/home/sea";
      version = "26.11";
      timezone = "Europe/London";
      locale = "en_GB.UTF-8";
      keyboardLayout = "gb";
      consoleKeyMap = "uk";
      shellMonitor = "DP-1";
      wallpaper = "wallhaven-je8p85_1920x1200.png";
      kernel = "jovian";
      browser = "helium";
      gtkTheme = "Adwaita-dark";
      iconTheme = "breeze-dark";
      disk = {
        device = "/dev/disk/by-id/nvme-KINGSTON_OM3PGP41024P-A0_50026B72833B3C2B";
        tmpfsSize = "4G";
      };
      impermanence.enable = true;
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
      };
      umbrielConfig = ./umbriel.conf;
    };
  };
}
