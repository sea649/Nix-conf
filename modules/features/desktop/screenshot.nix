{...}: {
  flake.nixosModules.screenshot = {pkgs, ...}: let
    commonPkgs = with pkgs; [
      coreutils
      grim
      satty
      slurp
      wl-clipboard
    ];

    monitorPkgs =
      commonPkgs
      ++ (with pkgs; [
        jq
        umbriel
      ]);

    common = ''
      set -euo pipefail

      dir="''${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
      mkdir -p "$dir"
      outfile="$dir/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"

      capture() {
        satty \
          --filename - \
          --output-filename "$outfile" \
          --early-exit \
          --actions-on-enter save-to-clipboard \
          --save-after-copy \
          --copy-command wl-copy \
          --app-id org.satty.satty \
          --floating-hack
      }
    '';
  in {
    environment.systemPackages = with pkgs; [
      (pkgs.writeShellApplication {
        name = "screenshot-region";
        runtimeInputs = commonPkgs;
        text = ''
          ${common}

          geometry="$(slurp)" || exit 0
          [[ -n "$geometry" ]] || exit 0
          grim -t ppm -g "$geometry" - | capture
        '';
      })

      (pkgs.writeShellApplication {
        name = "screenshot-monitor";
        runtimeInputs = monitorPkgs;
        text = ''
          ${common}

          monitor="$(umbriel outputs --json 2>/dev/null |
            jq -r '.[] | select(.focused) | .name' |
            head -n1 || true)"

          if [[ -n "$monitor" ]]; then
            grim -t ppm -o "$monitor" - | capture
          else
            grim -t ppm - | capture
          fi
        '';
      })
    ];
  };
}
