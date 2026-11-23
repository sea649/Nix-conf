{moduleWithSystem, ...}: {
  flake.wrappers.fish = {
    wlib,
    pkgs,
    lib,
    self',
    ...
  }: {
    imports = [wlib.wrapperModules.fish];

    flags."--no-config" = false;

    runtimePkgs = with pkgs; [
      bat
      carapace
      fzf
      zoxide
      microfetch
      nh
      git
    ];

    abbreviations = {
      cd.function = lib.getExe pkgs.zoxide;
      cat.function = lib.getExe pkgs.bat;
      v.function = lib.getExe self'.packages.nvim;
      man = "man -P \"${lib.getExe pkgs.bat} -p\"";
      ni = "z ~/Nix-conf/";
      niv = "z ~/Nix-conf/ && nvim";
    };

    configFile.content = ''
        status is-interactive; and begin
          source ${./catppuccin.fish}

          microfetch
          set fish_greeting ""
          oh-my-posh init fish | source
          fzf --fish | source
          zoxide init fish | source
          bind \cg git-branch-switch

          if set -q KITTY_INSTALLATION_DIR
            set --global KITTY_SHELL_INTEGRATION no-rc
            source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
            set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
          end

          set -gx CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense'
          carapace _carapace fish | source
        end

        function nsh 
          cd ~/Nix-conf
          IN_NIX_SHELL=impure nix shell nixpkgs#$argv
        end

      function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi $argv --cwd-file="$tmp"
        if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
          builtin cd -- "$cwd"
        end
        command rm -f -- "$tmp"
      end
    '';
  };

  flake.nixosModules.fish = moduleWithSystem ({self', ...}: {
    programs.fish = {
      enable = true;
      package = self'.packages.fish;
    };
  });
}
