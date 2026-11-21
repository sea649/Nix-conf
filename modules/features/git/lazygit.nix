{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.lazygit = moduleWithSystem ({self', ...}: {
    environment.systemPackages = [self'.packages.lazygit];
  });
  perSystem = {pkgs, ...}: let
    config-file = pkgs.writeText "config.yml" ''
      gui:
        nerdFontsVersion: "3"        # Maple Mono NF is Nerd Fonts v3
        showFileTree: true
        theme:
          activeBorderColor: ['#cba6f7', bold]
          inactiveBorderColor: ['#a6adc8']
          searchingActiveBorderColor: ['#f9e2af']
          optionsTextColor: ['#89b4fa']
          selectedLineBgColor: ['#313244']
          inactiveViewSelectedLineBgColor: ['#6c7086']
          cherryPickedCommitFgColor: ['#cba6f7']
          cherryPickedCommitBgColor: ['#45475a']
          markedBaseCommitFgColor: ['#89b4fa']
          markedBaseCommitBgColor: ['#f9e2af']
          unstagedChangesColor: ['#f38ba8']
          defaultFgColor: ['#cdd6f4']
          authorColors:
            '*': '#b4befe'
          branchColorPatterns:
            '.*': '#b4befe'          # inside theme, plain string
      os:
        editPreset: nvim
        open: 'xdg-open {{filename}} >/dev/null'
        openLink: 'xdg-open {{link}}'
      disableStartupPopups: true
      confirmOnQuit: false
      update:
        method: never
      refresher:
        fetchInterval: 60
      git:
        autoFetch: true
        log:
          showGraph: always
          order: topo-order
        diffRenderers:
          - command: delta --paging=never
    '';
  in {
    packages.lazygit = inputs.wrappers.lib.wrapPackage ({...}: {
      inherit pkgs;
      package = pkgs.lazygit;
      flags = {
        "--use-config-file" = config-file;
      };
    });
  };
}
