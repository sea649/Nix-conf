{ moduleWithSystem, ... }: {
  flake.wrappers.fish = { wlib, pkgs, config, ... }: {
    imports = [ wlib.wrapperModules.fish ];

    runtimePkgs = [
      pkgs.bat
      pkgs.fzf
      pkgs.zoxide
      pkgs.microfetch
      pkgs.nh
      pkgs.git
    ];

    abbreviations = {
      nos = "nh os switch";
      nou = "nix flake update --flake ~/Nix-conf; and nh os switch";
      ncl = "nh clean all";
      cat = "bat";
      v = "nvim";
      ni = "cd ~/Nix-conf/";
    };

    env = {
      FZF_DEFAULT_OPTS = "--height 40%";
      MANROFFOPT = "-c";
      MANPAGER = "sh -c 'col -bx | nvim -c \"set ft=man\" -'";
    };

    configFile.content = ''
      status is-interactive; and begin
        if test -f /etc/stylix/fish.fish
          source /etc/stylix/fish.fish
        end

        microfetch
        set fish_greeting ""
        starship init fish | source
        fzf --fish | source
        zoxide init fish | source
        bind \cg git-branch-switch

        if set -q KITTY_INSTALLATION_DIR
          set --global KITTY_SHELL_INTEGRATION no-rc
          source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
          set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
        end
      end

      function git-branch-switch
        set -l branch (git branch --sort=-committerdate | fzf --height 40%)
        and test -n "$branch"
        and git checkout (string trim "$branch")
      end

    function y
      set tmp (mktemp -t "yazi-cwd.XXXXXX")
      command yazi $argv --cwd-file="$tmp"
      if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
      end
      command rm -f -- "$tmp"
    end
    if test -d /etc/fish/generated_completions
      set -a fish_complete_path /etc/fish/generated_completions
    end
    '';
  };

  flake.nixosModules.fish = moduleWithSystem ({ self', ... }: {
    programs.fish = {
      enable = true;
      package = self'.packages.fish;
    };
  });
}
