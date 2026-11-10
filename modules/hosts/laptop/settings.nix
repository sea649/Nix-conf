{ ... }: {
  flake.nixosModules.laptop-options = { ... }: {
    dotfiles = {
      username = "sea";
      email = " ";
      hostname = "laptop";
      homeDirectory = "/home/sea";
      version = "26.11";
      timezone = "Europe/London";
      locale = "en_GB.UTF-8";
      keyboardLayout = "gb";
      consoleKeyMap = "uk";
      shellMonitor = "eDP-1";
      wallpaper = "wallhaven-je8p85_1920x1200.png";
      kernel = "zen";
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
