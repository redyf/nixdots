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
        local wezterm = require 'wezterm'
        return {
          color_scheme = "catppuccin-macchiato",
          default_cursor_style = "SteadyBlock",
          font = wezterm.font {
            family = "TX-02",
            weight = "Medium",
            italic = false, 
          },
          font_rules = {
            {
              intensity = 'Normal',
              italic = true,
              font = wezterm.font { family = 'TX-02', weight = 'Regular', italic = false, style = 'Normal' },
            },
            {
              intensity = 'Half',
              italic = true,
              font = wezterm.font { family = 'TX-02', weight = 'Regular', italic = false, style = 'Normal' },
            },
            {
              intensity = 'Bold',
              italic = true,
              font = wezterm.font { family = 'TX-02', weight = 'Bold', italic = false, style = 'Normal' },
            },
            {
              intensity = 'Normal',
              italic = false,
              font = wezterm.font { family = 'TX-02', weight = 'Medium', italic = false, style = 'Normal' },
            },
            {
              intensity = 'Half',
              italic = false,
              font = wezterm.font { family = 'TX-02', weight = 'Medium', italic = false, style = 'Normal' },
            },
            {
              intensity = 'Bold',
              italic = false,
              font = wezterm.font { family = 'TX-02', weight = 'Bold', italic = false, style = 'Normal' },
            },
          },
          -- harfbuzz_features = { 'ss02=1', 'ss07=1' },
          font_size = 16.0,
          hide_tab_bar_if_only_one_tab = true,
          webgpu_power_preference = "HighPerformance",
          window_background_opacity = 0.8,
          kde_window_background_blur = false,
          warn_about_missing_glyphs = false,
        }
      '';
    };
  };
}
