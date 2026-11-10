{ ... }: {
  flake.nixosModules.nightlight = { pkgs, ... }: {
    environment.systemPackages = [
      (pkgs.writeShellApplication {
        name = "nightlight-start";
        runtimeInputs = [ pkgs.wlsunset ];
        text = ''
        wlsunset -S 07:00 -s 19:00 -t 4000 -T 6500
        '';
      })
    ];
  };
}
