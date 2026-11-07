{ ... }: {
  flake.nixosModules.prism-symlink = { pkgs, ... }: {
    environment.systemPackages = [
      (pkgs.writeShellApplication {
        name = "prism-symlink";
        runtimeInputs = [ pkgs.coreutils ];
        text = ''
          set -euo pipefail
          SCREENSHOTS_SRC="$HOME/Pictures/minecraft screenshots"
          RESOURCEPACKS_BASE="$HOME/Projects/resource packs"
          SHADERS_BASE="$HOME/Projects/shaders"
          if [[ "$(basename "$PWD")" != "minecraft" ]]; then
            echo "Warning: current directory is '$(basename "$PWD")', not 'minecraft'."
            read -rp "Continue anyway? [y/N] " confirm
            [[ "$confirm" =~ ^[Yy]$ ]] || {
              echo "Aborted."
              exit 1
            }
          fi
          read -rp "Minecraft version for this instance (e.g. 1.20.1 or 1.21.1): " version
          pack_dir="$RESOURCEPACKS_BASE/$version"
          if [[ ! -d "$pack_dir" ]]; then
            echo "Warning: '$pack_dir' doesn't exist yet."
            read -rp "Create it now? [y/N] " make_dir
            if [[ "$make_dir" =~ ^[Yy]$ ]]; then
              mkdir -p "$pack_dir"
            else
              echo "Aborted — nothing was changed."
              exit 1
            fi
          fi
          shader_dir="$SHADERS_BASE/$version"
          if [[ ! -d "$shader_dir" ]]; then
            echo "Warning: '$shader_dir' doesn't exist yet."
            read -rp "Create it now? [y/N] " make_shader_dir
            if [[ "$make_shader_dir" =~ ^[Yy]$ ]]; then
              mkdir -p "$shader_dir"
            else
              echo "Aborted — nothing was changed."
              exit 1
            fi
          fi
          if [[ ! -d "$SCREENSHOTS_SRC" ]]; then
            echo "Error: '$SCREENSHOTS_SRC' doesn't exist. Create it first, then rerun."
            exit 1
          fi
          rm -rf ./resourcepacks ./screenshots ./shaderpacks
          ln -s "$pack_dir" "./resourcepacks"
          ln -s "$SCREENSHOTS_SRC" "./screenshots"
          ln -s "$shader_dir" "./shaderpacks"
          echo "Done:"
          echo "  resourcepacks -> $pack_dir"
          echo "  screenshots   -> $SCREENSHOTS_SRC"
          echo "  shaderpacks   -> $shader_dir"
        '';
      })
    ];
  };
}
