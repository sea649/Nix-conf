{self, ...}: {
  flake.nixosModules.terminal-utils = {...}: let
    modules = with self.nixosModules; [
      oh-my-posh
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
