{ ... }: {
  flake.nixosModules.opencode-launcher = { pkgs, ... }: {
    environment.systemPackages = [
      (pkgs.writeShellApplication {
        name = "opencode-launcher";
        runtimeInputs = [
          pkgs.opencode
          pkgs.fzf
          pkgs.findutils
        ];
        text = ''
          set -euo pipefail
          dir=$(find ~ -maxdepth 4 -type d 2>/dev/null | fzf) || exit
          cd "$dir"
          exec opencode
        '';
      })
    ];
  };
}
