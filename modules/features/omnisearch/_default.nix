{ inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.omnisearch =
      inputs.omnisearch.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  flake.nixosModules.omnisearch = { ... }: {
    imports = [ inputs.omnisearch.nixosModules.default ];

    services.omnisearch = {
      enable = true;
      configFile = ./config.ini;
    };
  };
}
