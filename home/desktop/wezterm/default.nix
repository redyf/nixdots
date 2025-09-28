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
          color_scheme = "tokyonight_moon",
          cursor_blink_rate = 0,
          default_cursor_style = "BlinkingBlock",
          font = wezterm.font {
            family = "TX-02",
            weight = "Medium",
            italic = false,
          },
          font_size = 15.0,
          hide_tab_bar_if_only_one_tab = true,
          webgpu_power_preference = "HighPerformance",
          window_background_opacity = 0.8,
          kde_window_background_blur = true,
          warn_about_missing_glyphs = false,
        }
      '';
    };
  };
}
