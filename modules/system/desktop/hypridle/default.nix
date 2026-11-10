{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.hypridle = moduleWithSystem ({self', ...}: {
    environment.systemPackages = [ self'.packages.hypridle ];
  });

  perSystem = {pkgs, self', ...}: {
    packages.hypridle = inputs.wrappers.lib.wrapPackage ({...}: {
      inherit pkgs;
      package = pkgs.hypridle;

      runtimePkgs = [
        self'.packages.hyprlock
        pkgs.procps
      ];

      flags."--config" = pkgs.writeText "hypridle.conf" (
        builtins.readFile ./hypridle.conf
      );
    });
  };
}
