{ ... }: {
  flake.nixosModules.bootloader = { pkgs, config, ... }: {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.configurationLimit = 10;

    boot.kernelPackages =
      if config.dotfiles.kernel == "zen" then
        pkgs.linuxPackages_zen
      else if config.dotfiles.kernel == "jovian" then
        pkgs.jovianPackages.linuxPackages
      else
        pkgs.linuxPackages_latest;
  };
}
