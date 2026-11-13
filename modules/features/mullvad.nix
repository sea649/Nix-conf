{...}: {
  flake.nixosModules.mullvad = {...}: {
    services.mullvad-vpn = {
      enable = true;
      enableEarlyBootBlocking = true;
      gui = {
        enable = true;
      };
    };
  };
}
