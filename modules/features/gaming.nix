{ self, ... }: {
  flake.nixosModules.gaming = { pkgs, config, ... }: {
      imports = [
        self.nixosModules.prism-symlink
        self.nixosModules.sync-ironfall
      ];
      environment.systemPackages = with pkgs; [
        mangohud
        prismlauncher
        heroic
      ];
      hjem.users.${config.dotfiles.username}.files = {
        ".local/share/PrismLauncher/catpacks".source = ../../assets/prismlauncher/catpacks;
        ".local/share/PrismLauncher/themes".source = ../../assets/prismlauncher/themes;
        ".local/share/PrismLauncher/iconthemes".source = ../../assets/prismlauncher/iconthemes;
      };
      programs = {
        gamemode.enable = true;
        gamescope.enable = true;
        steam = {
          enable = true;
          extraPackages = [ pkgs.bibata-cursors ];
        };
      };
    };
}
