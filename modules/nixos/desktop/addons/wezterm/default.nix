{
  options,
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.addons.wezterm;
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme}) colors;
in {
  options.desktop.addons.wezterm = with types; {
    enable = mkBoolOpt false "Enable or disable the wezterm terminal.";
  };

  config = mkIf cfg.enable {
    home.extraOptions.programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      extraConfig = ''
              local wezterm = require "wezterm"
              local act = wezterm.action
              local xcursor_size = 32
              local xcursor_theme = "macOS-BigSur"
              return {
                adjust_window_size_when_changing_font_size = false,
                animation_fps = 0,
                check_for_updates = false,
                cell_width = 0.88,
                cursor_blink_ease_in = 'EaseIn',
                cursor_blink_ease_out = 'EaseOut',
                color_scheme = "Catppuccin Mocha",
                default_cursor_style = "SteadyBlock",
                enable_scroll_bar = false,
                enable_tab_bar = false,
                enable_wayland = false,
                font_size = 15,
                font = wezterm.font('MonoLisa', { weight = 'Medium', italic = false }),
                font = wezterm.font_with_fallback {
                { family = 'MonoLisa', weight = 'Medium', italic = false },
                'Noto Color Emoji',
                },
                freetype_load_flags = 'NO_HINTING',
                freetype_load_target = 'Normal',
                -- front_end = "WebGpu",
                hide_tab_bar_if_only_one_tab = true,
                hide_mouse_cursor_when_typing = false,
                line_height = 1.0,
                scrollback_lines = 8000,
                term = "xterm-256color",
                use_fancy_tab_bar = false,
                warn_about_missing_glyphs = false,
                window_decorations = "RESIZE",
                window_background_opacity = 0.98,
                window_padding = {
                  left = 10,
                  right = 10,
                  top = 10,
                  bottom = 10,
                },
                xcursor_theme = xcursor_theme,
                xcursor_size = xcursor_size,
        --        leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 },
        --        keys = {
        --        { key = 'w', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true }, },
        --        { key = 'h', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
        --        { key = 'v', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
        --        { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
        --        { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
        --        { key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
        --        { key = 'C', mods = 'CTRL', action = act.CopyTo 'ClipboardAndPrimarySelection', },
        --        { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
        --        { key = 'Space', mods = 'CTRL', action = wezterm.action.ShowTabNavigator },
        --        },
                mouse_bindings = {
                { event = { Up = { streak = 1, button = 'Left' } }, mods = 'NONE', action = act.CompleteSelection 'Clipboard', },},
              }
      '';
    };
  };
}
