{moduleWithSystem, ...}: {
  flake.wrappers.kitty = {wlib, ...}: {
    imports = [wlib.wrapperModules.kitty];

    settings = {
      shell = "fish";
      background_opacity = "0.85";
      confirm_os_window_close = 0;
      cursor_trail = 100;
      cursor_trail_decay = "0.1 0.4";
      cursor_trail_start_threshold = 2;
      tab_bar_style = "powerline";

      # Catppuccin Mocha (base16)
      background = "#1e1e2e";
      foreground = "#cdd6f4";
      selection_background = "#6c7086";
      selection_foreground = "#cdd6f4";
      cursor = "#cdd6f4";
      cursor_text_color = "#1e1e2e";
      url_color = "#a6adc8";
      active_border_color = "#6c7086";
      inactive_border_color = "#313244";
      wayland_titlebar_color = "#1e1e2e";
      active_tab_background = "#1e1e2e";
      active_tab_foreground = "#cdd6f4";
      inactive_tab_background = "#313244";
      inactive_tab_foreground = "#a6adc8";
      tab_bar_background = "#313244";
      color0 = "#1e1e2e";
      color1 = "#f38ba8";
      color2 = "#a6e3a1";
      color3 = "#f9e2af";
      color4 = "#89b4fa";
      color5 = "#cba6f7";
      color6 = "#94e2d5";
      color7 = "#cdd6f4";
      color8 = "#45475a";
      color9 = "#f38ba8";
      color10 = "#a6e3a1";
      color11 = "#f9e2af";
      color12 = "#89b4fa";
      color13 = "#cba6f7";
      color14 = "#94e2d5";
      color15 = "#b4befe";
      color16 = "#fab387";
      color17 = "#f2cdcd";
      color18 = "#313244";
      color19 = "#45475a";
      color20 = "#a6adc8";
      color21 = "#f5e0dc";
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
    flags."--single-instance" = true;
  };
  flake.nixosModules.kitty = moduleWithSystem (
    {self', ...}: {
      environment.systemPackages = [self'.packages.kitty];
    }
  );
}
