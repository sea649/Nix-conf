{ self, ... }: {
  flake.nixosModules.system = { ... }: let
    modules = with self.nixosModules; [
      audio
      agenix
      bootloader
      disko
      fonts
      hardware
      impermanence
      networking
      nix
      options
      services
      setup
      user
      fish
      git
      syncthing
      hjem
    ];
  in {
    imports = modules;
  };
}
