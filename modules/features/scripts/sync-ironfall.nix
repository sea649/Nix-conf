{ ... }: {
  flake.nixosModules.sync-ironfall = { pkgs, ... }: {
    environment.systemPackages = [
      (pkgs.writeShellApplication {
        name = "sync-ironfall";
        runtimeInputs = [
          pkgs.coreutils
          pkgs.gnused
        ];
        text = ''
          set -euo pipefail
          SRC="/home/sea/.local/share/PrismLauncher/instances/Ironfall AUTOMODPACK/minecraft/automodpack/client/active"
          DST="/home/sea/.local/share/PrismLauncher/instances/IRONFALL Github/minecraft"
          rm -rf "$DST/config" "$DST/kubejs" "$DST/scripts" "$DST/mods"
          cp -r "$SRC/." "$DST/"
          compgen -G "$SRC/mods/*" | sed 's#.*/##; s/\.[^.]*$//' > "$DST/modlist.txt"
          echo "Synced to $DST"
        '';
      })
    ];
  };
}
