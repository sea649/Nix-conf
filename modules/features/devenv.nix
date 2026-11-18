{...}: {
  flake.nixosModules.devenv = {pkgs, ...}: {
    programs.devenv = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
