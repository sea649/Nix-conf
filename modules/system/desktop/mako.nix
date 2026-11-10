{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.mako = moduleWithSystem ({self', ...}: {
    environment.systemPackages = [ self'.packages.mako ];
  });

  perSystem = {pkgs, ...}: {
    packages.mako = inputs.wrappers.wrappers.mako.wrap {
      inherit pkgs;
      settings = {
        font = "Maple Mono NF 10";
        anchor = "top-right";
        layer = "overlay";
        width = 360;
        height = 120;
        "outer-margin" = 12;
        margin = 6;
        padding = 12;
        "border-radius" = 0;
        "default-timeout" = 5000;
        "group-by" = "app-name";

        "background-color" = "#1e1e2eee";
        "text-color" = "#cdd6f4";
        "border-color" = "#89b4fa";
        "progress-color" = "over #313244";

        "urgency=low" = { "border-color" = "#6c7086"; };
        "urgency=critical" = {
          "border-color" = "#f38ba8";
          "default-timeout" = 0;
        };
      };
    };
  };
}
