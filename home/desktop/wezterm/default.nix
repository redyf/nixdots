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
          font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium", italic = false}),
          font_size = 14.0,
          hide_tab_bar_if_only_one_tab = true,
          max_fps = 120,
          webgpu_power_preference = "HighPerformance",
          window_background_opacity = 0.8,
          kde_window_background_blur = true,
          warn_about_missing_glyphs = false,
        }
      '';
    };
  };
}
