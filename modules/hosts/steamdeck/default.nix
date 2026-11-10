{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.steamdeck = inputs.nixpkgs.lib.nixosSystem {
    modules =
      [
        inputs.jovian.nixosModules.default
        {jovian.devices.steamdeck.enable = true;}
        ({lib, ...}: {
          boot.kernelParams = lib.mkAfter [
            "fbcon=rotate:0"
            "video=eDP-1:d"
          ];
        })
      ]
      ++ (with self.nixosModules; [
        steamdeck-options
        system
        desktop
        terminal-utils
        gaming
        blockbench
        freetube
        newsflash
        stremio
        discord
        ./_hardware-configuration.nix
      ]);
  };
}
