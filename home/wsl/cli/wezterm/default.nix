_: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require "wezterm"
      local act = wezterm.action
      local xcursor_size = 32
      local xcursor_theme = "macOS-BigSur"
      return {
        check_for_updates = false,
                          font_size = 18,
                          font = wezterm.font('CaskaydiaCove Nerd Font', { weight = 'Bold', italic = true }),
                          font = wezterm.font_with_fallback {
                            { family = 'CaskaydiaCove Nerd Font', weight = 'Bold', italic = true },
                            'Noto Color Emoji',
                          },
                          adjust_window_size_when_changing_font_size = false,
                          animation_fps = 1,
                          default_cursor_style = "SteadyBlock",
                          cursor_blink_ease_in = 'EaseIn',
                          cursor_blink_ease_out = 'EaseOut',
                          color_scheme = "Oxocarbon Dark",
                          enable_scroll_bar = false,
                          enable_tab_bar = false,
                          enable_wayland = false,
                          front_end = "WebGpu",
                          use_fancy_tab_bar = false,
                          xcursor_theme = xcursor_theme,
                          xcursor_size = xcursor_size,
                          window_decorations = "RESIZE",
                          hide_tab_bar_if_only_one_tab = true,
                          window_background_opacity = 0.5,
                          scrollback_lines = 8000,
                          window_padding = {
                            left = 4,
                            right = 4,
                            top = 5,
                            bottom = 4,
                          },
                          leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 },
                          keys = {
                            { key = 'w', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true }, },
                            { key = 'h', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
                            { key = 'v', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
                            { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
                            { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
                            { key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
                            { key = 'C', mods = 'CTRL', action = act.CopyTo 'ClipboardAndPrimarySelection', },
                            { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
                             { key = 'Space', mods = 'CTRL', action = wezterm.action.ShowTabNavigator },},
                          mouse_bindings = {
                            { event = { Up = { streak = 1, button = 'Left' } }, mods = 'NONE', action = act.CompleteSelection 'Clipboard', },
                          },
      }
    '';
  };

  xdg.configFile."wezterm/colors/.oxocarbon-dark.toml".text = ''
    [colors]
    background = '#161616'
      foreground = '#ffffff'
      cursor_bg = '#ffffff'
      cursor_border = '#ffffff'
      cursor_fg = '#161616'

      ansi = [
      '#262626',
    '#ee5396',
    '#42be65',
    '#ffe97b',
    '#33b1ff',
    '#ff7eb6',
    '#3ddbd9',
    '#dde1e6',
      ]
        brights = [
        '#393939',
      '#ee5396',
      '#42be65',
      '#ffe97b',
      '#33b1ff',
      '#ff7eb6',
      '#3ddbd9',
      '#ffffff',
        ]

          [colors.tab_bar]
          background = "#262626"

            [colors.tab_bar.active_tab]
            bg_color = '#161616'
              fg_color = '#ffffff'
              intensity = 'Normal'
              italic = false
              strikethrough = false
              underline = 'None'

              [colors.tab_bar.inactive_tab]
              bg_color = '#262626'
                fg_color = '#ffffff'
                intensity = 'Normal'
                italic = false
                strikethrough = false
                underline = 'None'

                [colors.tab_bar.new_tab]
                bg_color = '#262626'
                  fg_color = '#ffffff'
                  intensity = 'Normal'
                  italic = false
                  strikethrough = false
                  underline = 'None'


                  [metadata]
                  name = 'Oxocarbon Dark'
                    origin_url = 'https://github.com/nyoom-engineering/oxocarbon'

  '';
}
