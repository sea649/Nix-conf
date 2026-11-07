  require("full-border"):setup({ type = ui.Border.PLAIN })
  require("git"):setup({
    -- Order of status signs showing in the linemode
    order = 1500,
  })
  require("githead"):setup({
    order = {
      "__spacer__",
      "branch",
      "remote",
      "__spacer__",
      "tag",
      "__spacer__",
      "commit",
      "__spacer__",
      "behind_ahead_remote",
      "stashes",
      "state",
      "staged",
      "unstaged",
      "untracked",
    },

    show_numbers = false,

    branch_symbol = " ",
    branch_prefix = "on",
  })
  require("smart-enter"):setup({
    open_multi = true,
  })
  require("bunny"):setup({
    hops = {
      { key = "/",          path = "/",                                    },
      { key = "t",          path = "/tmp",                                 },
      { key = "n",          path = "/nix/store",     desc = "Nix store"    },
      { key = "~",          path = "~",              desc = "Home"         },
      { key = "m",          path = "~/Music",        desc = "Music"        },
      { key = "d",          path = "~/Downloads",    desc = "Downloads"    },
      { key = "N",          path = "~/Sync/Notes",    desc = "Notes"    },
      { key = "D",          path = "~/Nix-conf",    desc = "Nix-conf"    },
      { key = "p",          path = "~/Projects",    desc = "Projects"    },
      { key = "P",          path = "~/.local/share/PrismLauncher/instances", desc = "PrismLauncher" },
      { key = "c",          path = "~/.config",      desc = "Config files" },
      { key = { "l", "s" }, path = "~/.local/share", desc = "Local share"  },
      { key = { "l", "b" }, path = "~/.local/bin",   desc = "Local bin"    },
      { key = { "l", "t" }, path = "~/.local/state", desc = "Local state"  },
      -- key and path attributes are required, desc is optional
    },
    desc_strategy = "path", -- If desc isn't present, use "path" or "filename", default is "path"
    ephemeral = true, -- Enable ephemeral hops, default is true
    tabs = true, -- Enable tab hops, default is true
    notify = false, -- Notify after hopping, default is false
    fuzzy_cmd = "fzf", -- Fuzzy searching command, default is "fzf"
  })
