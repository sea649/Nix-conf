{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.zsh = moduleWithSystem ({self', ...}: {
    programs.zsh = {
      enable = true;
      package = self'.packages.zsh;
      enableCompletion = true;
      enableBashCompletion = true;
      histSize = 10000;
      histFile = "$HOME/.local/state/zsh/history";
      compInitDumpFile = "$HOME/.local/state/zsh/zcompdump";
      autosuggestions = {
        enable = true;
        highlightStyle = "fg=#6c7086";
      };
      syntaxHighlighting = {
        enable = true;
        styles = {
          default = "fg=#a6adc8";
          comment = "fg=#6c7086";
          commandseparator = "fg=#89b4fa";
          redirection = "fg=#94e2d5";
        };
      };
    };
    users.defaultUserShell = self'.packages.zsh;
  });
  perSystem = {
    inputs',
    pkgs,
    self',
    lib,
    ...
  }: {
    packages.zsh = inputs.wrappers.wrappers.zsh.wrap {
      inherit pkgs;

      hmSessionVariables = null;

      runtimePkgs = [
        pkgs.bat
        pkgs.carapace
        pkgs.devenv
        pkgs.fzf
        pkgs.lsd
        pkgs.microfetch
        pkgs.nix-your-shell
        pkgs.zoxide
        self'.packages.lazygit
        self'.packages.oh-my-posh
        inputs'.neovim-conf.packages.default
      ];

      zshAliases = {
        ls = "${lib.getExe pkgs.lsd} -l";
        v = lib.getExe inputs'.neovim-conf.packages.default;
        cat = lib.getExe pkgs.bat;
        lg = lib.getExe self'.packages.lazygit;
        man = "man -P \"${lib.getExe pkgs.bat} -p\"";
        ni = "cd ~/Nix-conf/";
        niv = "cd ~/Nix-conf/ && nvim";
      };

      zshrc.content = ''
        eval "$(${lib.getExe self'.packages.oh-my-posh} init zsh)"

        eval "$(${lib.getExe pkgs.zoxide} init zsh --cmd cd)"

        source <(${lib.getExe pkgs.fzf} --zsh)

        export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
        source <(${lib.getExe pkgs.carapace} _carapace zsh)

        if [[ -n "$KITTY_INSTALLATION_DIR" ]]; then
          export KITTY_SHELL_INTEGRATION="enabled"
          autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
          kitty-integration
          unfunction kitty-integration
        fi

        ${lib.getExe pkgs.nix-your-shell} zsh | source /dev/stdin

        if (( ''${+terminfo[smkx]} )) && (( ''${+terminfo[rmkx]} )); then
          function zle-line-init() { echoti smkx }
          function zle-line-finish() { echoti rmkx }
          zle -N zle-line-init
          zle -N zle-line-finish
        fi

        autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
        zle -N up-line-or-beginning-search
        zle -N down-line-or-beginning-search
        bindkey "^[OA" up-line-or-beginning-search
        bindkey "^[OB" down-line-or-beginning-search
        bindkey "^[[A" up-line-or-beginning-search
        bindkey "^[[B" down-line-or-beginning-search

        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        bindkey "^[[3;5~" kill-word
        bindkey "^H" backward-kill-word

        autoload -U select-word-style
        select-word-style bash
        setopt NO_CASE_GLOB

        zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
        zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

        zle_highlight=(region:fg=#cdd6f4,bg=#45475a,bold isearch:fg=#f9e2af,bg=#45475a)

        microfetch

        nsh() {
          cd ~/Nix-conf || return
          local p
          local pkgs=()
          for p in "$@"; do
            pkgs+=("nixpkgs#$p")
          done
          IN_NIX_SHELL=impure nix shell "''${pkgs[@]}"
        }

        y() {
          local tmp=$(mktemp -t yazi-cwd.XXXXXX) || return
          command yazi "$@" --cwd-file="$tmp"
          local cwd
          cwd=$(<"$tmp")
          [[ -n "$cwd" && "$cwd" != "$PWD" && -d "$cwd" ]] && builtin cd -- "$cwd"
          command rm -f -- "$tmp"
        }
      '';
    };
  };
}
