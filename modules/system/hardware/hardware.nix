{ ... }: {
  flake.nixosModules.hardware = { ... }: {
    hardware.bluetooth.enable = true;
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    zramSwap = {
      enable = true;
      memoryPercent = 50;
    };
    services.earlyoom = {
      enable = true;
      freeMemThreshold = 10;
    };
  };
}
