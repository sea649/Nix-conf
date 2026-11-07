{ moduleWithSystem, ... }: let
  tmuxConfig = builtins.readFile ./tmux.conf;
  tmuxConfigNoTheme =
    builtins.replaceStrings
    ["source-file ~/.config/tmux/themes/noctalia.conf"]
    [""]
    tmuxConfig;
in {
  flake.wrappers.tmux = { wlib, lib, pkgs, ... }: {
    imports = [ wlib.wrapperModules.tmux ];

    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      yank
    ];

    configAfter = lib.mkAfter ''
      source-file /etc/stylix/tmux.conf
      ${tmuxConfigNoTheme}
    '';
  };

  flake.nixosModules.tmux = moduleWithSystem ({ self', ... }: {
    environment.systemPackages = [ self'.packages.tmux ];
  });
}
