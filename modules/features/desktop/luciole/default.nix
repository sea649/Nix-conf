{inputs, ...}: {
  flake.nixosModules.luciole = {
    pkgs,
    config,
    lib,
    ...
  }: let
    luciole = inputs.luciole.packages.${pkgs.stdenv.hostPlatform.system}.default;

    configFile = pkgs.runCommand "luciole-config.toml" {} ''
      cp ${./config.toml} $out
    '';
  in {
    environment.systemPackages = [
      luciole
      pkgs.file-roller
      pkgs.unzip
      pkgs.p7zip
    ];

    hjem.users.${config.dotfiles.username}.files = {
      ".config/luciole/config.toml".source = configFile;

      ".local/share/dbus-1/services/org.freedesktop.FileManager1.service".text = ''
        [D-BUS Service]
        Name=org.freedesktop.FileManager1
        Exec=${lib.getExe luciole} --file-manager-service
      '';
    };

    services.gvfs.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [luciole];
      config.umbriel."org.freedesktop.impl.portal.FileChooser" = ["luciole"];
    };
  };
}
