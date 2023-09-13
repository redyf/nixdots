_: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require "wezterm"

      return {
        font_size = 14,
        color_scheme = "Oxocarbon Dark",
        window_background_opacity = 1.0,
        enable_scroll_bar = false,
        enable_tab_bar = false,
        scrollback_lines = 10000,
        window_padding = {
          left = 10,
          right = 10,
          top = 10,
          bottom = 10,
        },
        check_for_updates = false,
        default_cursor_style = "BlinkingBar",
      }
    '';
  };
}
