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
          default_cursor_style = "SteadyBlock",
          harfbuzz_features = { 'ss02=1', 'ss07=1' },
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
