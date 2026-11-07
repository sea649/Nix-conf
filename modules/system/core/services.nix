{ ... }: {
  flake.nixosModules.services = { ... }: {
    services = {
      printing.enable = true;
      fstrim.enable = true;
      openssh = {
        enable = true;
        settings.PasswordAuthentication = true;
      };
      gnome.gnome-keyring.enable = true;
    };
    security.sudo.wheelNeedsPassword = false;
  };
}
