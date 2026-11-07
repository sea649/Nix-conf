{ self, inputs, ... }: {
  flake.nixosModules.beets = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.beets
    ];
  };

  perSystem = { pkgs, ... }: {
    packages.beets = inputs.wrappers.lib.wrapPackage (
      { ... }: {
        inherit pkgs;
        package = pkgs.beets;
        env.BEETSDIR = "${pkgs.linkFarm "beets-config" [
          {
            name = "config.yaml";
            path = ./config.yaml;
          }
        ]}";
      }
    );
  };
}
