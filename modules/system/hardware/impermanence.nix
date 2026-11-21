{inputs, ...}: {
  flake.nixosModules.impermanence = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkIf;
    cfg = config.dotfiles;
    persist = cfg.impermanence.persistPath;
  in {
    imports = [inputs.impermanence.nixosModules.impermanence];

    config = mkIf cfg.impermanence.enable {
      # /etc/shadow is on tmpfs, so runtime `passwd` changes would be lost.
      # Use a hash file on the persistent volume instead.
      users.mutableUsers = false;
      users.users.${cfg.username}.hashedPasswordFile = "${persist}/passwords/${cfg.username}";

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
          "/etc/mullvad-vpn"
          "/var/lib/nixos"
          "/var/lib/systemd"
          "/var/lib/NetworkManager"
          "/var/lib/bluetooth"
          "/var/lib/fwupd"
          "/var/lib/AccountsService"
          "/var/lib/upower"
          "/var/lib/alsa"
          "/var/lib/cups"
          "/var/lib/hjem"
          "/var/lib/ly"
          "/var/lib/power-profiles-daemon"
          # "/var/lib/fprint"
          "/var/log"
        ];

        files = ["/etc/machine-id"];

        users.${cfg.username}.directories = [
          # user data
          "Nix-conf"
          "Sync"
          "Notes"
          "Documents"
          "Pictures"
          "Music"
          "Projects"
          "wallpaper"
          "neovim"
          "org"
          "Backups"

          # secrets / identity
          {
            directory = ".ssh";
            mode = "0700";
          }
          {
            directory = ".gnupg";
            mode = "0700";
          }
          {
            directory = ".local/share/keyrings";
            mode = "0700";
          }
          ".pki"
          ".keys"
          ".opencode"
          ".config/age"

          # browsers / profiles
          ".librewolf"
          ".config/librewolf"
          ".config/net.imput.helium"

          # installed app config
          ".config/obsidian"
          ".config/Blockbench"
          ".config/thunderbird"
          ".config/tutanota-desktop"
          ".config/Mullvad VPN"
          ".config/FreeTube"
          ".config/heroic"
          ".config/keepassxc"
          ".config/obs-studio"
          ".config/vesktop"
          ".config/concord"
          ".config/news-flash"
          ".config/sonora"
          ".config/syncthing"
          ".config/opencode"
          ".config/umbriel"

          # editor / terminal / shell config
          ".config/nvim"
          ".config/nvf"
          ".config/lazyvim"
          ".config/nvim-personal"
          ".config/SEA-neovim-config"
          ".config/yazi"
          ".config/zellij"
          ".config/kitty"
          ".config/fish"
          ".local/share/zoxide"
          ".local/state/fzf"
          ".config/tmux"
          ".config/btop"
          ".local/state/lazygit"
          ".config/gh"
          ".config/jj"
          ".config/mpv"
          ".config/Thunar"
          ".config/nordend"
          ".config/luciole"
          ".config/fsel"
          ".config/fuzzel"
          ".config/hypr"
          ".config/dconf"
          ".config/systemd"
          ".config/environment.d"
          ".config/xdg-desktop-portal-wlr"
          ".config/xsettingsd"
          ".config/qt5ct"
          ".config/qt6ct"
          ".config/qtengine"
          ".config/gtk-3.0"
          ".config/gtk-4.0"

          # application data
          ".local/share/Steam"
          ".steam"
          ".local/share/applications"
          ".local/share/opencode"
          ".local/share/nvim"
          ".local/share/nvf"
          ".local/share/lazyvim"
          ".local/share/nvim-personal"
          ".local/share/SEA-neovim-config"
          ".local/share/news-flash"
          ".local/share/sonora"
          ".local/share/fractal"
          ".local/share/iamb"
          ".local/share/stremio"
          ".local/share/zathura"
          ".local/share/com.github.johnfactotum.Foliate"
          ".local/share/fish"
          ".local/share/PrismLauncher"
          ".local/share/nix"
          ".local/share/icons"

          # runtime state worth keeping
          ".local/state/SEA-neovim-config/undo"
          ".local/state/SEA-neovim-config/shada"
          ".local/state/syncthing"
          ".local/state/syncthing-versions"
          ".local/state/opencode"
          ".local/state/nordend"
          ".local/state/luciole"
          ".local/state/Heroic"
          ".local/state/keepassxc"
          ".local/state/nix"
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
        fileSystems = ["/nix"];
      };
    };
  };
}
