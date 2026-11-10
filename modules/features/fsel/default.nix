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

  perSystem = {pkgs, ...}: {
    packages.fsel = inputs.wrappers.lib.wrapPackage (
      {...}: {
        inherit pkgs;
        package = pkgs.fsel;
        flags = {
          "-c" = ./config.toml;
        };
      }
    );
  };
}
