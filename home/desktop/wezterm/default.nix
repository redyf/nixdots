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
          color_scheme = "Catppuccin Mocha",
          default_cursor_style = "SteadyBlock",
          font_size = 18.0,
          font = wezterm.font_with_fallback {
            {
              family = 'TX-02',
              weight = 'Regular',
              harfbuzz_features = { 'ss02=1' },
              italic = false,
            },
            {
              family = 'MonoLisa',
              weight = 'Medium',
              harfbuzz_features = { 'ss02=1', 'ss07=1' },
            },
            {
              family = 'JetBrains Mono Nerd Font',
              weight = 'Medium',
            },
          },
          hide_tab_bar_if_only_one_tab = true,
          freetype_load_flags = "NO_HINTING",
          freetype_load_target = "Normal",
          line_height = 1.0,
          front_end = "OpenGL",
          window_background_opacity = 1.0,
          kde_window_background_blur = false,
          warn_about_missing_glyphs = false,
        }
      '';
    };
  };
}
