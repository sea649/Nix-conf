{ ... }: {
  flake.nixosModules.desktop-utils = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      perlPackages.ImageExifTool
      mpv
      zathura
    ];
  };
}
