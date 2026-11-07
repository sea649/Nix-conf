{ inputs, self, ... }: {
  flake.nixosModules.stylix =
    { pkgs, config, ... }:
    let
      image = "${inputs.wallpapers}/${config.dotfiles.wallpaper}";
      polarity = "dark";

      colors = config.lib.stylix.colors;
      stylixInputs = config.stylix.inputs;

      # Keep starship's config in modules/features/starship/default.nix as the
      # source of truth, but replace its Noctalia palette with the Stylix one.
      starshipBase = self.wrappers.starship.settings;
      starshipPalette = with colors.withHashtag; {
        black = base00;
        red = base08;
        green = base0B;
        yellow = base0A;
        blue = base0D;
        magenta = base0E;
        cyan = base0C;
        white = base05;
        bright-black = base03;
        bright-red = base09;
        bright-green = base0A;
        bright-yellow = base0B;
        bright-blue = base0D;
        bright-magenta = base0E;
        bright-cyan = base0C;
        bright-white = base07;
        orange = base09;
        brown = base0A;
      };
      starshipConfig = (pkgs.formats.toml { }).generate "starship.toml" (
        starshipBase
        // {
          palette = "base16";
          palettes = (starshipBase.palettes or { }) // {
            base16 = starshipPalette;
          };
        }
      );
    in
    {
      imports = [
        inputs.stylix.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
      ];

      stylix = {
        enable = true;
        inherit image polarity;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        fonts = {
          monospace = {
            name = "Maple Mono NF";
            package = pkgs.maple-mono.NF;
          };
          sansSerif = {
            name = "Noto Sans";
            package = pkgs.noto-fonts;
          };
          serif = {
            name = "Noto Serif";
            package = pkgs.noto-fonts;
          };
          emoji = {
            name = "Noto Color Emoji";
            package = pkgs.noto-fonts-color-emoji;
          };

          sizes = {
            applications = 10;
            terminal = 10;
            desktop = 10;
            popups = 10;
          };
        };

        cursor = {
          name = config.dotfiles.cursor.theme;
          package = config.dotfiles.cursor.package;
          size = config.dotfiles.cursor.size;
        };

        targets = {
          # These are handled by the wrappers / dedicated system files below.
          fish.enable = false;
          gtk.enable = false;
          qt.enable = false;
        };
      };

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        overwriteBackup = true;
        extraSpecialArgs = { inherit inputs; };
      };

      home-manager.users.${config.dotfiles.username} = {
        home.username = config.dotfiles.username;
        home.homeDirectory = config.dotfiles.homeDirectory;
        home.stateVersion = config.dotfiles.version;

        stylix = {
          enable = true;
          autoEnable = false;

          targets = {
            gtk.enable = true;
            fontconfig.enable = true;
            font-packages.enable = true;

            fish.enable = false;
            kitty.enable = false;
            starship.enable = false;
            yazi.enable = false;
            neovim.enable = false;
            tmux.enable = false;
          };
        };
      };

      environment.etc = {
        "stylix/fish.fish".text = ''
          source ${colors { templateRepo = stylixInputs.base16-fish; }}
          if test -z $TMUX && test -z $ZELLIJ
            base16-${colors.slug}
          end
        '';

        "stylix/kitty.conf".source = colors {
          templateRepo = stylixInputs.tinted-kitty;
          target = "base16";
        };

        "stylix/tmux.conf".source = colors {
          templateRepo = stylixInputs.tinted-tmux;
          target = "base16";
        };

        "stylix/starship.toml".source = starshipConfig;

        "stylix/nvim.lua".text = ''
          require("base16-colorscheme").setup({
            base00 = "${colors.withHashtag.base00}", base01 = "${colors.withHashtag.base01}",
            base02 = "${colors.withHashtag.base02}", base03 = "${colors.withHashtag.base03}",
            base04 = "${colors.withHashtag.base04}", base05 = "${colors.withHashtag.base05}",
            base06 = "${colors.withHashtag.base06}", base07 = "${colors.withHashtag.base07}",
            base08 = "${colors.withHashtag.base08}", base09 = "${colors.withHashtag.base09}",
            base0A = "${colors.withHashtag.base0A}", base0B = "${colors.withHashtag.base0B}",
            base0C = "${colors.withHashtag.base0C}", base0D = "${colors.withHashtag.base0D}",
            base0E = "${colors.withHashtag.base0E}", base0F = "${colors.withHashtag.base0F}",
          })
          vim.g.colors_name = "base16"
        '';
      };
    };
}
