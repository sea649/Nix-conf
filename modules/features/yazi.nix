{inputs, ...}: {
  flake.nixosModules.yazi = {
    imports = [inputs.yazi-conf.nixosModules.yazi];
  };
}
