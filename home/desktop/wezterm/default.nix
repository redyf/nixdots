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
              intensity = 'Bold',
              italic = false,
              font = wezterm.font { family = 'TX-02', weight = 'Bold', italic = false },
            },
            {
              intensity = 'Half', 
              italic = false,
              font = wezterm.font { family = 'TX-02', weight = 'Medium', italic = false },
            },
            {
              intensity = 'Normal', 
              italic = false,
              font = wezterm.font { family = 'TX-02', weight = 'Medium', italic = false },
            },
          },
          -- harfbuzz_features = { 'ss02=1', 'ss07=1' },
          font_size = 13.0,
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
