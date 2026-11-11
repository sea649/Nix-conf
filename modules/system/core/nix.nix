{ inputs, ... }: {
  flake.nixosModules.nix = { config, ... }: {
    imports = [
      inputs.nix-index-database.nixosModules.nix-index
    ];
    nixpkgs.overlays = [
      inputs.umbriel.overlays.default
    ];
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      max-jobs = "auto";
      cores = 0;
      auto-optimise-store = true;
      build-dir = "/nix/tmp";
    };
    systemd.tmpfiles.rules = [ "d /nix/tmp 0755 root root -" ];
    programs.nh = {
      enable = true;
      flake = config.dotfiles.repoPath;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 5 --keep-since 3d";
      };
    };
    nixpkgs.config.allowUnfree = true;
    programs.nix-index-database.comma.enable = true;
  };
}
