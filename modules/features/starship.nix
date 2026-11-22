{moduleWithSystem, ...}: {
  flake.wrappers.starship = {wlib, ...}: {
    imports = [wlib.wrapperModules.starship];

    settings = {
      palette = "base16";
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

      palettes.base16 = {
        black = "#1e1e2e";
        red = "#f38ba8";
        green = "#a6e3a1";
        yellow = "#f9e2af";
        blue = "#89b4fa";
        magenta = "#cba6f7";
        cyan = "#94e2d5";
        white = "#cdd6f4";

        "bright-black" = "#6c7086";
        "bright-red" = "#fab387";
        "bright-green" = "#f9e2af";
        "bright-yellow" = "#a6e3a1";
        "bright-blue" = "#89b4fa";
        "bright-magenta" = "#cba6f7";
        "bright-cyan" = "#94e2d5";
        "bright-white" = "#b4befe";

        orange = "#fab387";
        brown = "#f9e2af";
      };
    };
  };

  flake.nixosModules.starship = moduleWithSystem (
    {self', ...}: {
      environment.systemPackages = [self'.packages.starship];
    }
  );
}
