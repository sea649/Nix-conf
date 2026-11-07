{ ... }: {
  flake.nixosModules.syncthing =
    { config, lib, ... }: let
      hostName = config.dotfiles.hostname;
      home = config.dotfiles.homeDirectory;

      devices = {
        steamdeck.id = "BGVIWJF-XKN67RA-UJC37YQ-EA7VOGD-EFCJ233-SHC7WVB-WVHBZ7J-2GH7WQQ";
        laptop.id = "YH5BM5M-7U352IE-QJ6M3UO-AMASA26-E6FCW35-T43IXJS-3K3KOTI-DAH7DAM";
        iphone.id = "3ASOP7Q-XL7QZC3-DA5HBVZ-6H62A3X-QF5OSN4-FSZNW3B-C3CDLPB-XAIZUAU";
      };

      peers = lib.filterAttrs (name: _: name != hostName) devices;
    in
    {
      services.syncthing = {
        enable = true;

        # NixOS runs Syncthing as a system service, so point it at the
        # real user and writable per-user config/data locations.
        user = config.dotfiles.username;
        group = "users";
        configDir = "${home}/.config/syncthing";
        databaseDir = "${home}/.local/state/syncthing";

        settings = {
          devices = peers;

          folders.keepass = {
            path = "~/Sync/keepass";
            id = "keepass"; # must be identical on every device
            label = "KeePass";
            devices = lib.attrNames peers;
            type = "sendreceive";
            ignorePerms = true;

            versioning = {
              type = "staggered";
              fsPath = "${home}/.local/state/syncthing-versions/keepass";
              params = {
                cleanInterval = "3600";
                maxAge = "7776000"; # 90 days
              };
            };

            ignorePatterns = [
              "(?d).~lock.*" # KeePassXC lock file
              "(?d).stfolder"
              "(?d).stignore"
              "(?d).stversions"
              "(?d)*.tmp"
              "(?d).DS_Store"
            ];
          };

          folders.Notes = {
            path = "~/Sync/Notes";
            id = "Notes"; # must be identical on every device
            label = "Notes";
            devices = lib.attrNames peers;
            type = "sendreceive";
            ignorePerms = true;

            versioning = {
              type = "staggered";
              fsPath = "${home}/.local/state/syncthing-versions/Notes";
              params = {
                cleanInterval = "3600";
                maxAge = "7776000"; # 90 days
              };
            };

            ignorePatterns = [
              "(?d).~lock.*" # KeePassXC lock file
              "(?d).stfolder"
              "(?d).stignore"
              "(?d).stversions"
              "(?d)*.tmp"
              "(?d).DS_Store"
            ];
          };

          options = {
            urAccepted = -1;
            localAnnounceEnabled = true;
            relaysEnabled = true;
          };

          gui.theme = "black";
        };
      };

      systemd.services.syncthing.serviceConfig.UMask = "0077";
    };
}
