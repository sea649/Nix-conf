{ ... }: {
  flake.nixosModules.mako = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
      mako
      ];
  };
}
