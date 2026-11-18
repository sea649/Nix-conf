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
      mullvad
      obs
      obsidian
      opencode
      qbittorrent
      sonora
      luciole
      tuta

      # -- Utils --
      beets
      desktop-utils
      fsel
      gtk
      xkg
      xsettingsd
      devenv
    ];
  in {
    imports = modules;
  };
}
