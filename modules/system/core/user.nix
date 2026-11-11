{ ... }: {
  flake.nixosModules.user = { config, lib, pkgs, ... }: {
    users.users.${config.dotfiles.username} = {
      isNormalUser = true;
      initialPassword = lib.mkIf (!config.dotfiles.impermanence.enable) "password";
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
