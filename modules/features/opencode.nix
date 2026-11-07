{ self, ... }: {
  flake.nixosModules.opencode = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      opencode
    ];
    imports = [
      self.nixosModules.opencode-launcher
    ];
  };
}
