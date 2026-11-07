{ moduleWithSystem, ... }: {
  flake.wrappers.git = { wlib, ... }: {
    imports = [ wlib.wrapperModules.git ];
    settings = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      pull.rebase = true;
      user.name = "sea";
      user.email = " ";
    };
  };
  flake.nixosModules.git = moduleWithSystem (
    { self', ... }: {
      programs.git = {
        enable = true;
        package = self'.packages.git;
      };
    }
  );
}
