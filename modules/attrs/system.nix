{self, ...}: {
  flake.nixosModules.system = {...}: let
    modules = with self.nixosModules; [
      audio
      agenix
      bootloader
      console
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
      zsh
      git
      delta
      syncthing
      readme-onefetch
      hjem
    ];
  in {
    imports = modules;
  };
}
