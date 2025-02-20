{
  pkgs,
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
      enableZshIntegration = true;
      extraConfig = ''
        return {
          font = wezterm.font("MonoLisa", { weight = "Medium"}),
          font_size = 12.0,
          hide_tab_bar_if_only_one_tab = true,
          cursor_blink_rate = 0,
          window_background_opacity = 0.90,
          harfbuzz_features = { 'calt=0', 'liga=1', 'zero=1', 'ss01=1', 'ss02=1', 'ss07=1', 'ss10=1', 'ss11=1', 'ss18=1' },
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
