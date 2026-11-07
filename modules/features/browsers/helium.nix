{ inputs, ... }: {
  flake.nixosModules.helium = { ... }: {
    imports = [ inputs.helium.nixosModules.default ];
    programs.helium.enable = true;
  };
}

