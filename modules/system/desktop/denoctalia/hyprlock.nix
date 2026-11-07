{ ... }: {
  flake.nixosModules.hyprlock = { pkgs, ... }: {
    programs = {
      hyprlock.enable = true;
      hypridle.enable = true;
    };
    security.pam.services.hyprlock = { };
  };
}
