{ inputs, ... }: {
  flake.nixosModules.swaybg = { pkgs, config, ... }: {
    environment.systemPackages = with pkgs; [
      (pkgs.writeShellApplication {
        name = "swaybg-start";
        runtimeInputs = [
          swaybg
        ];
        text = ''
          exec swaybg -i ${inputs.wallpapers}/${config.dotfiles.wallpaper} -m fill
        '';
      })
    ];
  };
}
