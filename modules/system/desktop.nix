{ self, ... }: {
  flake.nixosModules.desktop =
    { ... }:
    let
      modules = with self.nixosModules; [
        greeter
        umbriel
        noctalia
        swaybg
        otter-launcher
        thunar
        gtk
        xsettingsd
        kitty
        stylix
        beets
        sonora
        proton
        browser
        desktop-utils
        obsidian
        foliate
        opencode
        xkg
        obs
        keepassxc
      ];
    in
    {
      imports = modules;
    };
}
