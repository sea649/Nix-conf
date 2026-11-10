{
  moduleWithSystem,
  inputs,
  ...
}:
{
  flake.nixosModules.waybar = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = with self'.packages; [
        waybar
      ];
    }
  );
  perSystem = { pkgs, ... }: {
    packages.waybar = inputs.wrappers.wrappers.waybar.wrap {
      inherit pkgs;
      "style.css".path = ./style.css;
      configFile.content = ''
        {
        		"include": [
        			"${./modules.jsonc}"
        		],
              "layer": "top",
            "height": 30,
            "margin": "3 6",
            "spacing": 8,
            "reload_style_on_change": true,
            "position": "top",
            "modules-left": [
              "privacy",
            "tray",
            "ext/workspaces",
            "mpris"
            ],
            "modules-center": [
                "clock"
            ],
            "modules-right": [
            "pulseaudio",
            "network",
            "power-profiles-daemon",
            "cpu",
            "memory",
            "battery",
            ],
        }
      '';
    };
  };
}
