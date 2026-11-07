{ ... }: {
  flake.nixosModules.proton = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      proton-vpn
      proton-pass
      tutanota-desktop
    ];
  };
}
