{ moduleWithSystem, ... }: {
  flake.wrappers.kitty = { wlib, lib, ... }: {
    imports = [ wlib.wrapperModules.kitty ];

    extraConfig = lib.mkAfter "include /etc/stylix/kitty.conf";

    settings = {
      shell = "fish";
      background_opacity = "0.85";
      confirm_os_window_close = 0;
      cursor_trail = 100;
      cursor_trail_decay = "0.1 0.4";
      cursor_trail_start_threshold = 2;
      tab_bar_style = "powerline";
    };
    font.name = "Maple Mono NF";
    keybindings = {
      "ctrl+1" = "goto_tab 1";
      "ctrl+2" = "goto_tab 2";
      "ctrl+3" = "goto_tab 3";
      "ctrl+4" = "goto_tab 4";
      "ctrl+5" = "goto_tab 5";
      "ctrl+6" = "goto_tab 6";
      "ctrl+7" = "goto_tab 7";
      "ctrl+8" = "goto_tab 8";
      "ctrl+9" = "goto_tab 9";
      "ctrl+alt+h" = "neighboring_window left";
      "ctrl+alt+j" = "neighboring_window down";
      "ctrl+alt+k" = "neighboring_window up";
      "ctrl+alt+l" = "neighboring_window right";
      "ctrl+super+shift+h" = "resize_window narrower 50";
      "ctrl+super+shift+j" = "resize_window taller 50";
      "ctrl+super+shift+k" = "resize_window shorter 50";
      "ctrl+super+shift+l" = "resize_window wider 50";
      "shift+up" = "scroll_line_up";
      "shift+down" = "scroll_line_down";
      "shift+pageup" = "scroll_page_up";
      "shift+pagedown" = "scroll_page_down";
      "ctrl+alt+t" = "new_tab_with_cwd";
      "ctrl+alt+w" = "close_tab";
    };
  };
  flake.nixosModules.kitty = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = [self'.packages.kitty];
    }
  );
}
