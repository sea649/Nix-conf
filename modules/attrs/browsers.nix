
{ self, ... }: {
  flake.nixosModules.browser = { config, ... }: let
    modules = with self.nixosModules; [
      helium
      librewolf
    ];
  in {
    imports = modules;
    environment.sessionVariables.BROWSER = config.dotfiles.browser;
  };
}
