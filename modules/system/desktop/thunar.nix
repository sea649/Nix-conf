{ ... }: {
  flake.nixosModules.thunar = { config, lib, pkgs, ... }: {
      xdg.portal.enable = true;
      programs = {
        thunar = {
          enable = true;
          plugins = with pkgs; [
            thunar-archive-plugin
          ];
        };
        xfconf.enable = true;
      };
      services = {
        gvfs.enable = true;
        tumbler.enable = true;
      };

      programs.dconf.enable = true;
      environment.systemPackages = with pkgs; [
        file-roller
      ];
    };
}
