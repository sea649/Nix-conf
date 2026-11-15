{...}: {
  flake.nixosModules.mullvad = {pkgs, ...}: let
    mullvadSettings = pkgs.writeText "mullvad-settings.json" (
      builtins.toJSON {
        allow_lan = true;
        auto_connect = true;
        lockdown_mode = true;
        update_default_location = false;

        relay_settings.normal = {
          location.only.location.city = ["ch" "zrh"];
          wireguard_constraints = {
            ip_version = "any";
            use_multihop = false;
          };
        };

        tunnel_options.dns_options.default_options = {
          block_ads = true;
          block_trackers = true;
          block_malware = true;
        };
      }
    );
  in {
    services.mullvad-vpn = {
      enable = true;
      enableEarlyBootBlocking = true;
      enableExcludeWrapper = false;
      gui.enable = true;
    };

    systemd.services.mullvad-daemon.serviceConfig.ExecStartPre = "${pkgs.coreutils}/bin/install -Dm700 ${mullvadSettings} /etc/mullvad-vpn/settings.json";
  };
}
