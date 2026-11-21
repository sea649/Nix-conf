{...}: {
  flake.nixosModules.readme-onefetch = {
    config,
    pkgs,
    ...
  }: let
    updateReadme = pkgs.writeShellApplication {
      name = "update-readme-onefetch";
      runtimeInputs = with pkgs; [
        coreutils
        onefetch
        gnused
      ];
      text = ''
        cd "${config.dotfiles.repoPath}";

        onefetch -d pending head churn url --nerd-fonts 2>/dev/null | sed -E 's/\x1b\[[0-9;?]*[a-zA-Z]//g' > assets/onefetch.txt

        sed -i '/<!-- onefetch:start -->/,/<!-- onefetch:end -->/{/<!-- onefetch:start -->/!{/<!-- onefetch:end -->/!d;};}' README.md
        sed -i '/<!-- onefetch:start -->/r assets/onefetch.txt' README.md
      '';
    };
  in {
    environment.systemPackages = [updateReadme];

    system.activationScripts.update-readme-onefetch = {
      text = ''
        ${pkgs.util-linux}/bin/runuser -u ${config.dotfiles.username} -- env HOME=${config.dotfiles.homeDirectory} ${updateReadme}/bin/update-readme-onefetch
      '';
    };
  };
}
