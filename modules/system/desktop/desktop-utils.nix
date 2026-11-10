{...}: {
  flake.nixosModules.desktop-utils = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      perlPackages.ImageExifTool
      mpv
      zathura
      libnotify
    ];
    services = {
      upower.enable = true;
      power-profiles-daemon.enable = true;
    };
  };
}
