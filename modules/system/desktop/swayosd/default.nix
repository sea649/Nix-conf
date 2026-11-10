{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.swayosd = moduleWithSystem ({ self', pkgs, ... }: {
    environment.systemPackages = [
      self'.packages.swayosd
      pkgs.playerctl
    ];
    services.udev.packages = [ self'.packages.swayosd ];
  });

  perSystem = { pkgs, self', ... }: {
    packages.swayosd = inputs.wrappers.lib.wrapPackage ({ ... }: {
      inherit pkgs;
      package = pkgs.swayosd;
      wrapperVariants.server = {
        mirror = false;
        exePath = "bin/swayosd-server";
        binName = "swayosd-server";
        flags."--config" = ./config.toml;
        flags."--style" = ./style.css;
      };
    });
  };
}
