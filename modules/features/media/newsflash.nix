{ ... }: {
  flake.nixosModules.newsflash = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
    newsflash
    ];
  };
}


