{ ... }: {
  flake.nixosModules.stremio = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
    stremio-linux-shell
    ];
  };
}


