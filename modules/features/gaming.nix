{self, ...}: {
  flake.nixosModules.gaming = {
    pkgs,
    config,
    ...
  }: {
    imports = [
      self.nixosModules.prism-symlink
      self.nixosModules.sync-ironfall
    ];
    environment.systemPackages = with pkgs; [
      mangohud
      prismlauncher
      heroic
    ];
    programs = {
      gamemode.enable = true;
      gamescope.enable = true;
      steam = {
        enable = true;
        extraPackages = [pkgs.bibata-cursors];
      };
    };
  };
}
