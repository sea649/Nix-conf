{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.oh-my-posh = moduleWithSystem ({self', ...}: {
    environment.systemPackages = [self'.packages.oh-my-posh];
  });
  perSystem = {pkgs, ...}: {
    packages.oh-my-posh = inputs.wrappers.wrappers.oh-my-posh.wrap {
      inherit pkgs;
      package = pkgs.oh-my-posh;
      configFile = ./config.toml;
    };
  };
}
