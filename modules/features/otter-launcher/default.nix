{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.otter-launcher = moduleWithSystem (
    {
      self',
      pkgs,
      ...
    }: {
      environment.systemPackages = [
        self'.packages.otter-launcher
      ];
    }
  );
  perSystem = {
    pkgs,
    lib,
    self',
    inputs',
    ...
  }: {
    packages = {
      otter-launcher = let
        final-config = pkgs.writeText "config.toml" (builtins.readFile ./config.toml);
      in
        inputs.wrappers.lib.wrapPackage (
          {...}: {
            inherit pkgs;
            package = inputs'.otter-launcher.packages.default;
            runtimePkgs = with pkgs; [
              self'.packages.fsel
              bluetui
              wiremix
              networkmanager
            ];
            flags = {
              "-c" = final-config;
            };
          }
        );
    };
  };
}
