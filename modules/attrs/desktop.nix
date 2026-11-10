{self, ...}: {
  flake.nixosModules.desktop = {...}: let
    modules = with self.nixosModules; [
      # -- desktop environment --
      greeter
      hypridle
      hyprlock
      mako
      nightlight
      otter-launcher
      polkit-agent
      screenshot
      swaybg
      swayosd
      umbriel
      waybar

      # -- Apps --
      browser
      foliate
      keepassxc
      kitty
      obs
      obsidian
      opencode
      proton
      sonora
      thunar

      # -- Utils --
      beets
      desktop-utils
      gtk
      stylix
      xkg
      xsettingsd
    ];
  in {
    imports = modules;
  };
}
