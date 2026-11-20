{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.bottom = moduleWithSystem ({self', ...}: {
    environment.systemPackages = [self'.packages.bottom];
  });

  perSystem = {pkgs, ...}: {
    packages.bottom = inputs.wrappers.lib.wrapPackage ({...}: {
      inherit pkgs;
      package = pkgs.bottom;
      flags."--config_location" = ./bottom.toml;
    });
  };
}
