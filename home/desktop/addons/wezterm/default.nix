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
          cursor_blink_rate = 0,
          font = wezterm.font("TX-02", { weight = "Regular", italic = false}),
          font_size = 16.0,
          hide_tab_bar_if_only_one_tab = true,
          max_fps = 120,
          webgpu_power_preference = "HighPerformance",
          window_background_opacity = 0.8,
          warn_about_missing_glyphs = false,
        }
      '';
    };
  };
}
