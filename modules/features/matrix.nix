{self, ...}: {
  flake.wrappers.iamb = {wlib, ...}: {
    imports = [wlib.wrapperModules.iamb];
    settings = {
      default_profile = "matrix";
      settings = {
        default_markup = "markdown";
        image_preview = {
          protocol.type = "kitty";
          size = {
            width = 66;
            height = 10;
          };
        };
      };
    };
  };

  flake.nixosModules.matrix = {
    pkgs,
    config,
    ...
  }: {
    imports = [self.wrappers.iamb.install];
    wrappers.iamb.enable = true;
    wrappers.iamb.settings.profiles.matrix.user_id = "${config.dotfiles.matrix}";
    environment.systemPackages = [pkgs.fractal];
  };
}
