{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.delta = moduleWithSystem ({self', ...}: {
    environment.systemPackages = [self'.packages.delta];
  });

  perSystem = {pkgs, ...}: {
    packages.delta = inputs.wrappers.lib.wrapPackage ({...}: {
      inherit pkgs;
      package = pkgs.delta;
      flags = {
        "--dark" = true;
        "--syntax-theme" = "Catppuccin Mocha";

        # Catppuccin Mocha (https://github.com/catppuccin/delta)
        "--minus-style" = "syntax #493447";
        "--minus-emph-style" = "bold syntax #694559";
        "--plus-style" = "syntax #394545";
        "--plus-emph-style" = "bold syntax #4e6356";

        "--file-style" = "#cdd6f4";
        "--file-decoration-style" = "#6c7086";
        "--commit-decoration-style" = "#6c7086 bold box ul";
        "--hunk-header-style" = "file line-number syntax";
        "--hunk-header-file-style" = "bold";
        "--hunk-header-line-number-style" = "bold #a6adc8";
        "--hunk-header-decoration-style" = "#6c7086 box ul";

        "--line-numbers" = true;
        "--line-numbers-left-style" = "#6c7086";
        "--line-numbers-right-style" = "#6c7086";
        "--line-numbers-minus-style" = "bold #f38ba8";
        "--line-numbers-plus-style" = "bold #a6e3a1";
        "--line-numbers-zero-style" = "#6c7086";

        "--blame-palette" = "#1e1e2e #181825 #11111b #313244 #45475a";
        "--map-styles" = "bold purple => syntax #5b4e74, bold blue => syntax #445375, bold cyan => syntax #446170, bold yellow => syntax #6b635b";

        "--navigate" = true;
      };
    });
  };
}
