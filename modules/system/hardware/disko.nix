{ inputs, ... }: {
  flake.nixosModules.disko =
    { config, lib, ... }:
    let
      inherit (lib) mkIf;
      cfg = config.dotfiles;
      persist = cfg.impermanence.persistPath;

      btrfs = {
        type = "btrfs";
        extraArgs = [ "-f" ];
        subvolumes = {
          "@nix" = {
            mountpoint = "/nix";
            mountOptions = [ "compress=zstd" "noatime" ];
          };
          "@persist" = {
            mountpoint = persist;
            mountOptions = [ "compress=zstd" "noatime" ];
          };
          "@home" = {
            mountpoint = "${persist}/home";
            mountOptions = [ "compress=zstd" "noatime" ];
          };
        };
      };

      rootContent =
        if cfg.disk.encrypt then {
          type = "luks";
          name = "cryptroot";
          # initrdUnlock defaults to true; disko adds boot.initrd.luks.devices.cryptroot
          settings.allowDiscards = true;
          content = btrfs;
        } else btrfs;
    in {
      imports = [ inputs.disko.nixosModules.disko ];

      config = mkIf cfg.impermanence.enable {
        disko.devices = {
          disk.main = {
            type = "disk";
            device = cfg.disk.device;
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  name = "ESP";
                  size = "1G";
                  type = "EF00";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "umask=0077" ];
                  };
                };
                root = {
                  size = "100%";
                  content = rootContent;
                };
              };
            };
          };

          nodev."/" = {
            fsType = "tmpfs";
            mountOptions = [ "size=${cfg.disk.tmpfsSize}" "mode=755" ];
          };
        };

        fileSystems."${persist}".neededForBoot = true;
        fileSystems."${persist}/home".neededForBoot = true;
      };
    };
}
