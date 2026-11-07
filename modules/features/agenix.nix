{ inputs, ... }: {
  flake.nixosModules.agenix = { config, pkgs, ... }: {
    imports = [ inputs.agenix.nixosModules.default ];
    age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    age.secrets = {
      vfs = {
        file = ../../secrets/vfs-yazi.age;
        owner = config.dotfiles.username;
        mode = "0400";
      };
      newsFlash = {
        file = ../../secrets/newsFlash.age;
        owner = config.dotfiles.username;
        mode = "0400";
        path = "${config.dotfiles.repoPath}/Newsflash.OPML";
      };
    };
    environment.systemPackages = with pkgs; [
      age
      inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
