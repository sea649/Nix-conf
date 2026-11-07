{ moduleWithSystem, ... }: {
  flake.wrappers.<name> = { wlib, ... }: {
    imports = [ wlib.wrapperModules.<name> ];
    # either env pointing at repo/configs, or typed settings
  };

  flake.nixosModules.<name> = moduleWithSystem ({ self', ... }: {
    environment.systemPackages = [ self'.packages.<name> ];
  });
}
