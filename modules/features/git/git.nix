{moduleWithSystem, ...}: {
  flake.wrappers.git = {wlib, ...}: {
    imports = [wlib.wrapperModules.git];
    settings = {
      core.editor = "nvim";
      core.pager = "delta";
      init.defaultBranch = "main";
      interactive.diffFilter = "delta --color-only";
      merge.conflictStyle = "zdiff3";
      pull.rebase = true;
      user.name = "sea";
      user.email = " ";
    };
  };
  flake.nixosModules.git = moduleWithSystem (
    {self', ...}: {
      programs.git = {
        enable = true;
        package = self'.packages.git;
      };
    }
  );
}
