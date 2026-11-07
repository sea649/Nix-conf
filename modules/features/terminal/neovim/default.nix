{
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.neovim = moduleWithSystem (
    { inputs', ... }: {
      environment.systemPackages = [ inputs'.neovim-conf.packages.default ];

      environment.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    }
  );
}
