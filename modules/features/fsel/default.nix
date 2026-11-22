{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.fsel = moduleWithSystem (
    {self', ...}: {
      environment.systemPackages = [
        self'.packages.fsel
      ];
    }
  );

  perSystem = {
    pkgs,
    inputs',
    ...
  }: {
    packages.fsel = inputs.wrappers.lib.wrapPackage (
      {...}: {
        inherit pkgs;
        package = inputs'.fsel.packages.default;
        flags = {
          "-c" = ./config.toml;
        };
      }
    );
  };
}
