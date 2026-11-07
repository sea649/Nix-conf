{ ... }: {
  flake.nixosModules.user = { config, pkgs, ... }: {
    users.users.${config.dotfiles.username} = {
      isNormalUser = true;
      initialPassword = "password";
      extraGroups = [
        "networkmanager"
          "wheel"
          "audio"
          "video"
      ];
      shell = config.programs.fish.package;
    };
  };
}
