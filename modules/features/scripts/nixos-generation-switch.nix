{...}: {
  flake.nixosModules.nixos-generation-switch = {pkgs, ...}: {
    environment.systemPackages = [
      (pkgs.writeShellApplication {
        name = "nixos-generation-switch";
        runtimeInputs = [
          pkgs.coreutils
          pkgs.fsel
        ];
        text = ''
          set -euo pipefail
          choice=$(
            nixos-rebuild list-generations |
              tail -n +2 |
              fsel --dmenu --exit-if-empty
          ) || exit 0
          read -r gen _ <<< "$choice"
          [[ $gen =~ ^[0-9]+$ ]] || exit 1
          exec sudo nixos-rebuild switch --store-path "/nix/var/nix/profiles/system-$gen-link"
        '';
      })
    ];
  };
}
