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
      disk = {
        device = "/dev/disk/by-id/nvme-PSELN128GA17SC0_0525186035859";
        tmpfsSize = "2G";
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
