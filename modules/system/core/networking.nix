{ ... }: {
  flake.nixosModules.networking = {pkgs, ...}: {
    networking.networkmanager = {
      enable = true;
      plugins = [pkgs.networkmanager-openvpn];
    };
    networking.firewall = {
      allowedTCPPorts = [22000];
      allowedUDPPorts = [22000 21027];
    };
  };
}
