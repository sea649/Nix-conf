{ self, inputs, ... }: {
  flake.nixosModules.sonora = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.sonora
    ];
  };

  perSystem =
    { pkgs, lib, ... }:
    let
      settings = builtins.fromJSON (builtins.readFile ./settings.json);

      json = pkgs.formats.json { };
      generated = json.generate "sonora-settings.json" settings;

      apply = pkgs.writeShellApplication {
        name = "sonora-apply-settings";
        runtimeInputs = [ pkgs.jq ];
        text = ''
          generated=$1
          dest="''${XDG_CONFIG_HOME:-$HOME/.config}/sonora/settings.json"
          mkdir -p "$(dirname "$dest")"
          if [[ -f "$dest" ]]; then
            jq --indent 2 -s '.[0] * .[1]' "$dest" "$generated" > "$dest.tmp"
            mv "$dest.tmp" "$dest"
          else
            cp "$generated" "$dest"
          fi
        '';
      };

      merge = "${lib.getExe apply} ${generated}";

      alsaPluginDir = pkgs.symlinkJoin {
        name = "sonora-alsa-plugins";
        paths = [
          "${pkgs.pipewire}/lib/alsa-lib"
          "${pkgs.alsa-plugins}/lib/alsa-lib"
        ];
      };
    in
    {
      packages.sonora = inputs.wrappers.lib.wrapPackage (
        {
          config,
          wlib,
          lib,
          ...
        }:
        {
          inherit pkgs;
          package = inputs.sonora.packages.${pkgs.stdenv.hostPlatform.system}.default;
          env.ALSA_PLUGIN_DIR = "${alsaPluginDir}";
          runShell = [ merge ];
        }
      );
    };
}
