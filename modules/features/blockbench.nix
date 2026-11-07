{ ... }: {
  flake.nixosModules.blockbench = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
    blockbench
    ];
  };
}




