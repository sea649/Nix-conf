{ inputs, ... }: {
  flake.nixosModules.noctalia = { pkgs, config, ... }: let
      noctaliaConfigHome = pkgs.runCommand "noctalia-config-home" { } ''
        mkdir -p $out/noctalia
        ln -s ${config.dotfiles.noctaliaConfig} $out/noctalia/config.toml
      '';

      noctalia = inputs.wrappers.lib.wrapPackage ( { ... }: {
          inherit pkgs;
          package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
          env = {
            NOCTALIA_CONFIG_HOME = "${noctaliaConfigHome}";
            NOCTALIA_STATE_HOME = "${config.dotfiles.homeDirectory}/.local/state";
          };
        });
    in
    { imports = [ inputs.noctalia.nixosModules.default ];
      programs.noctalia = {
        enable = true;
        package = noctalia;
        recommendedServices.enable = true;
      };
    };
}
