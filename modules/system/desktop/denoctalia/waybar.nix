{ ... }: {
  flake.nixosModules.waybar = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
      waybar
      ];
  };
}

