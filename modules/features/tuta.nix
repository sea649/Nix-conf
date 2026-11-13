{...}: {
  flake.nixosModules.tuta = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      tutanota-desktop
    ];
  };
}
