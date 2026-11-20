{self, ...}: {
  flake.nixosModules.terminal-utils = {...}: let
    modules = with self.nixosModules; [
      starship
      tmux
      yazi
      neovim
      bottom
      terminal-tools
    ];
  in {
    imports = modules;
  };
}
