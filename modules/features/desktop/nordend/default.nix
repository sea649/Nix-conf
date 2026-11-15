{inputs, ...}: {
  flake.nixosModules.nordend = {pkgs, ...}: let
    nordend = (inputs.nordend.packages.${pkgs.stdenv.hostPlatform.system}.default).overrideAttrs (old: {
      postFixup =
        (old.postFixup or "")
        + ''
          wrapProgram $out/bin/nordend --add-flags "--config /etc/nordend/config.toml"
        '';
    });
  in {
    environment.etc."nordend/config.toml".source = ./config.toml;

    environment.systemPackages = [
      nordend
      (pkgs.writeTextDir "share/dbus-1/services/org.freedesktop.FileManager1.service" ''
        [D-BUS Service]
        Name=org.freedesktop.FileManager1
        Exec=${nordend}/libexec/nordend/nordend-portal --file-manager1
      '')
      pkgs.file-roller
      pkgs.unzip
      pkgs.p7zip
    ];

    programs.dconf.enable = true;
    services.gvfs.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [nordend];
      config.umbriel."org.freedesktop.impl.portal.FileChooser" = ["nordend"];
    };
  };
}
