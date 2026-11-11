{ inputs, ... }: {
  flake.nixosModules.impermanence =
    { config, lib, ... }:
    let
      inherit (lib) mkIf;
      cfg = config.dotfiles;
      persist = cfg.impermanence.persistPath;
    in {
      imports = [ inputs.impermanence.nixosModules.impermanence ];

      config = mkIf cfg.impermanence.enable {
        # /etc/shadow is on tmpfs, so runtime `passwd` changes would be lost.
        # Use a hash file on the persistent volume instead.
        users.mutableUsers = false;
        users.users.${cfg.username}.hashedPasswordFile =
          "${persist}/passwords/${cfg.username}";

        # Keep host keys on /persist and point sshd at them directly, so
        # agenix does not depend on a stage-2 /etc/ssh bind mount.
        services.openssh.hostKeys = lib.mkForce [
          {
            type = "ed25519";
            path = "${persist}/etc/ssh/ssh_host_ed25519_key";
          }
          {
            type = "rsa";
            bits = 4096;
            path = "${persist}/etc/ssh/ssh_host_rsa_key";
          }
        ];

        environment.persistence.${persist} = {
          hideMounts = true;

          directories = [
            "/etc/NetworkManager/system-connections"
            "/var/lib/nixos"
            "/var/lib/systemd"
            "/var/lib/NetworkManager"
            "/var/lib/bluetooth"
            "/var/lib/fwupd"
            "/var/lib/AccountsService"
            {
              directory = "/var/lib/colord";
              user = "colord";
              group = "colord";
              mode = "u=rwx,g=rx,o=";
            }
            "/var/lib/upower"
            "/var/lib/alsa"
            "/var/lib/cups"
            "/var/lib/hjem"
            "/var/lib/power-profiles-daemon"
            # "/var/lib/fprint"
            "/var/log"
          ];

          files = [ "/etc/machine-id" ];

          users.${cfg.username}.directories = [
            # user data
            "Nix-conf" "Sync" "Notes" "Documents" "Pictures" "Music"
            "Projects" "wallpaper" "neovim" "org" "pictures"
            # "pictures" is the lowercase wallpaper dir on the laptop;
            # on the Deck it is just an empty directory.

            # secrets / identity
            { directory = ".ssh"; mode = "0700"; }
            { directory = ".gnupg"; mode = "0700"; }
            { directory = ".local/share/keyrings"; mode = "0700"; }
            ".pki" ".keys" ".opencode"

            # application state
            ".config"
            ".local/share"
            ".local/state"
            ".librewolf" ".mozilla" ".steam"

            # caches stay on disk, not RAM
            ".cache"
          ];
        };

        # Directories that must exist before sshd/agenix/users run.
        # impermanence #254: DynamicUser services expect /var/lib/private 0700.
        systemd.tmpfiles.rules = [
          "d ${persist}/etc/ssh 0755 root root -"
          "d ${persist}/passwords 0700 root root -"
          "d ${persist}/var/lib/private 0700 root root -"
          "d /var/lib/private 0700 root root -"
        ];
        systemd.services."systemd-tmpfiles-resetup".serviceConfig.RemainAfterExit =
          lib.mkForce false;

        services.journald.settings.Journal.Storage = "persistent";
        services.btrfs.autoScrub = {
          enable = true;
          fileSystems = [ "/nix" ];
        };
      };
    };
}
