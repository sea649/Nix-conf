{ inputs, ... }: {
  flake.nixosModules.discord = { pkgs, config, ... }: {
    environment.systemPackages = [
      inputs.serein.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.concord-tui
      pkgs.vesktop
    ];
    hjem.users.${config.dotfiles.username}.files = {
      ".config/vesktop/settings/settings.json".source = ./vesktop-settings.json;
    };
  };
}
