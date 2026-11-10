{ self, ... }: {
  flake.nixosModules.system = { ... }: let
    modules = with self.nixosModules; [
      audio
      agenix
      bootloader
      fonts
      hardware
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
