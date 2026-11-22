{...}: {
  flake.nixosModules.qbittorrent = {
    config,
    pkgs,
    ...
  }: {
    services.qbittorrent = {
      enable = true;
      user = "qbittorrent";
      group = "users";
      profileDir = "/persist/var/lib/qBittorrent";
      webuiPort = 8080;

      serverConfig = {
        LegalNotice.Accepted = true;
        BitTorrent.Session = {
          Interface = "wg0-mullvad";
          DefaultSavePath = "/persist/torrents";
          LSDEnabled = false;
          GlobalMaxRatio = 0;
          ShareLimitAction = "Stop";
        };
        Network.PortForwardingEnabled = false;
        WebUI = {
          Address = "127.0.0.1";
          Username = config.dotfiles.username;
          LocalHostAuth = false;
        };
      };
    };

    systemd.tmpfiles.rules = ["d /persist/torrents 2775 qbittorrent users -"];

    systemd.services.qbittorrent.serviceConfig = {
      ExecStartPre = ["${pkgs.iproute2}/bin/ip link show wg0-mullvad"];
      Restart = "on-failure";
      RestartSec = "10s";
      UMask = "0002";
    };
  };
}
