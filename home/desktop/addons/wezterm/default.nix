{
  lib,
  config,
  ...
}:
{
  options = {
    wezterm.enable = lib.mkEnableOption "Enable Wezterm module";
  };
  config = lib.mkIf config.wezterm.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = ''
        return {
          font = wezterm.font("Maple Mono NF", { weight = "Medium", italic = false}),
          -- font = wezterm.font("Berkeley Mono", { weight = "Medium", italic = false}),
          -- font = wezterm.font("ZedMono Nerd Font", { weight = "Medium", italic = false}),
          -- font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium", italic = false}),
          font_size = 15.0,
          hide_tab_bar_if_only_one_tab = true,
          cursor_blink_rate = 0,
          color_scheme = "Catppuccin Mocha",
          max_fps = 120,
          webgpu_power_preference = "HighPerformance",
          window_background_opacity = 0.8,
          warn_about_missing_glyphs = false,
          -- harfbuzz_features = { 'calt=1', 'liga=1', 'ss01=1', 'ss02=1', 'ss03=1', 'ss04=1', 'ss05=1', 'ss06=1', 'ss07=1', 'ss08=1', 'ss09=1' },
          -- harfbuzz_features = { 'calt=0', 'liga=1', 'zero=1', 'ss01=1', 'ss02=1', 'ss07=1', 'ss10=1', 'ss11=1', 'ss18=1' },
        }
      '';
      # keybindings = {
      #   "ctrl+shift+c" = "copy_to_clipboard";
      #   "ctrl+shift+v" = "paste_from_clipboard";
      #   "ctrl+shift+s" = "paste_from_selection";
      #   "ctrl+shift+e" = "open_url";
      #   "ctrl+shift+=" = "increase_font_size";
      #   "ctrl+shift+-" = "decrease_font_size";
      #   "ctrl+shift+backspace" = "restore_font_size";
      #   "ctrl+shift+up" = "scroll_line_up";
      #   "ctrl+shift+k" = "scroll_line_up";
      #   "ctrl+shift+down" = "scroll_line_down";
      #   "ctrl+shift+j" = "scroll_line_down";
      #   "ctrl+shift+home" = "scroll_home";
      #   "ctrl+shift+n" = "new_os_window";
      #   "ctrl+shift+]" = "next_window";
      #   "ctrl+shift+[" = "previous_window";
      #   "ctrl+shift+right" = "next_tab";
      #   "ctrl+tab" = "next_tab";
      #   "ctrl+shift+tab" = "previous_tab";
      #   "ctrl+shift+left" = "previous_tab";
      #   "ctrl+shift+t" = "new_tab";
      #   "ctrl+shift+q" = "close_tab";
      # };
    };
  };
}
