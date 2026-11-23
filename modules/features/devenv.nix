{...}: {
  flake.nixosModules.devenv = {pkgs, ...}: {
    programs.devenv = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
