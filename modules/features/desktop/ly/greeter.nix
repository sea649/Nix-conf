{...}: {
  flake.nixosModules.greeter = {
    config,
    pkgs,
    ...
  }: {
    services.displayManager.ly = {
      enable = true;
      x11Support = false;

      settings = {
        bigclock = "en";
        bigclock_12hr = false;
        bigclock_seconds = false;

        initial_info_text = "Welcome to Umbriel";
        asterisk = "*";
        battery_id = "BAT1";
        save_file_dir = "/var/lib/ly";

        animation = "dur_file";
        dur_file_path = "${./blackhole-smooth-240x67.dur}";

        vi_mode = true;
        vi_default_mode = "insert";

        border_fg = "0x00B4BEFE";
        bg = "0x00313244";
        fg = "0x00cdd6f4";
      };
    };
    services.displayManager.defaultSession = "umbriel";

    systemd.tmpfiles.rules = [
      "d /var/lib/ly 0700 root root -"
    ];
  };
}
