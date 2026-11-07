{ moduleWithSystem, ... }: {
  flake.wrappers.starship = { wlib, lib, ... }: {
    imports = [ wlib.wrapperModules.starship ];

    env.STARSHIP_CONFIG = lib.mkForce "/etc/stylix/starship.toml";

    settings = {
      palette = "noctalia";
      add_newline = true;
      format = ''
        ╭─$cmd_duration $directory$git_branch$fill$character
        ╰─ '';

      fill = {
        symbol = "-";
        style = "fg:245";
      };

      character = {
        success_symbol = "[](bold fg:green)[  ](black bold bg:green)[](bold fg:green)";
        error_symbol = "[](bold fg:red)[  ](black bold bg:red)[](bold fg:red)";
      };

      package.disabled = true;

      git_branch = {
        style = "bg: 252";
        symbol = "󰘬";
        truncation_length = 12;
        truncation_symbol = "";
        format = " 󰜥 [](bold fg:252)[$symbol $branch(:$remote_branch)](fg:235 bg:252)[](bold fg:252)";
      };

      git_commit = {
        commit_hash_length = 4;
        tag_symbol = " ";
      };

      git_state = {
        format = "[\\($state( $progress_current of $progress_total)\\)]($style) ";
        cherry_pick = "[🍒 PICKING](bold red)";
      };

      git_status = {
        conflicted = " 🏳 ";
        ahead = " 🏎💨 ";
        behind = " 😰 ";
        diverged = " 😵 ";
        untracked = " 🤷 ‍";
        stashed = " 📦 ";
        modified = " 📝 ";
        staged = "[++\\($count\\)](green)";
        renamed = " ✍️ ";
        deleted = " 🗑 ";
      };

      hostname = {
        ssh_only = false;
        format = "[•$hostname](bg:252 bold fg:235)[](bold fg:252)";
        trim_at = ".companyname.com";
        disabled = false;
      };

      line_break.disabled = false;

      memory_usage = {
        disabled = true;
        threshold = -1;
        symbol = " ";
        style = "bold dimmed green";
      };

      time = {
        disabled = true;
        format = "🕙[\\[ $time \\]]($style) ";
        time_format = "%T";
      };

      username = {
        style_user = "bold bg:252 fg:235";
        style_root = "red bold";
        format = "[](bold fg:252)[$user]($style)";
        disabled = false;
        show_always = true;
      };

      directory = {
        home_symbol = " ";
        read_only = "  ";
        style = "bg:255 fg:240";
        truncation_length = 2;
        truncation_symbol = ".../";
        format = "[](bold fg:255)[󰉋 → $path]($style)[](bold fg:255)";

        substitutions = {
          "Desktop" = "  ";
          "Documents" = "  ";
          "Downloads" = "  ";
          "Music" = " 󰎈 ";
          "Games" = "  ";
          "Pictures" = "  ";
          "Videos" = "  ";
          "GitHub" = " 󰊤 ";
          "git_stuff" = "  stuff";
          "git" = "  ";
          "backup" = " 󰁯 ";
          "python-stuff" = "  stuff";
        };
      };

      cmd_duration = {
        min_time = 0;
        format = "[](bold fg:252)[󰪢 $duration](bold bg:252 fg:235)[](bold fg:252)";
      };

      palettes.noctalia = {
        blue = "#c7cd5b";
        red = "#ffb4ab";
        green = "#c8c9a6";
        yellow = "#a3d0bf";
        cyan = "#c8c9a6";
        magenta = "#c7cd5b";
        white = "#e5e2da";
        black = "#14140f";

        rosewater = "#a3d0bf";
        flamingo = "#a3d0bf";
        pink = "#c7cd5b";
        mauve = "#5e6300";
        maroon = "#ffb4ab";
        peach = "#a3d0bf";
        teal = "#c8c9a6";
        sky = "#c8c9a6";
        sapphire = "#c8c9a6";
        lavender = "#5e6300";

        text = "#e5e2da";
        subtext1 = "#c9c7b6";
        subtext0 = "#929182";

        overlay2 = "#929182";
        overlay1 = "#c9c7b6";
        overlay0 = "#47473b";
        surface2 = "#47473b";
        surface1 = "#14140f";
        surface0 = "#14140f";
        base = "#14140f";
        mantle = "#14140f";
        crust = "#08372b";
      };
    };
  };

  flake.nixosModules.starship = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = [ self'.packages.starship ];
    }
  );
}
