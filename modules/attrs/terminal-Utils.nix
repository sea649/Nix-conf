{self, ...}: {
  flake.nixosModules.terminal-utils = {...}: let
    modules = with self.nixosModules; [
      starship
      tmux
      yazi
      neovim
      bottom
      lazygit
      terminal-tools
    ];
  in {
    imports = modules;
  };
}
