{ self, ... }: {
  flake.nixosModules.terminal-utils = { ... }: let
    modules = with self.nixosModules; [
      starship
      tmux
      yazi
      neovim
      terminal-tools
    ];
  in {
    imports = modules;
  };
}

