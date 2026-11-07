{ self, inputs, ... }: {
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.nixos-hardware.nixosModules.common-cpu-amd
      inputs.nixos-hardware.nixosModules.common-gpu-amd

      ({ lib, ... }: {
        hardware.enableRedistributableFirmware = true;
        services.power-profiles-daemon.enable = true;
        services.fwupd.enable = true;

        # Force the security options; the generated hardware config uses 0022.
        fileSystems."/boot".options = lib.mkForce [
          "fmask=0077"
          "dmask=0077"
        ];
      })
    ]
    ++ (with self.nixosModules; [
      laptop-options
      system
      desktop
      terminal-utils
      freetube
      newsflash
      stremio
      ./_hardware-configuration.nix
    ]);
  };
}
