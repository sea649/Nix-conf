{ ... }: {
  flake.nixosModules.foliate = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
    foliate
    ];
  };
}




