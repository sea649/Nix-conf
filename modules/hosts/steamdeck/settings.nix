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
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
      };
      umbrielConfig = ./umbriel.conf;
    };
  };
}
