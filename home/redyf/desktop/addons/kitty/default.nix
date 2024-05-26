{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
      mode = "no-cursor";
    };
    # theme = "Tokyo Night";
    # theme = "Catppuccin-Mocha";
    # font = {
    #   # name = "JetBrainsMono Nerd Font";
    #   name = "MonoLisa";
    #   package = pkgs.monolisa-script;
    #   size = 11;
    # };
    # https://www.monolisa.dev/faq#how-to-enable-stylistic-sets-for-the-kitty-terminal
    extraConfig = ''
      font_features MonoLisa -calt +liga +zero +ss01 +ss02 +ss07 +ss08 +ss10 +ss11 +ss18
      modify_font cell_width 100%
      modify_font cell_height 100%
    '';
    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      # modify_font underline_position 4
      # modify_font underline_thickness 150%
      text_composition_strategy = "platform"; # platform or legacy
      sync_to_monitor = "yes";

      # Background
      # background_opacity = "1";

      # Cursor
      cursor_shape = "block";
      cursor_blink_interval = 0;

      # Don't ask for confirmation when closing a tab.
      confirm_os_window_close = 0;
      disable_ligatures = "never";

      copy_on_select = "clipboard";
      clear_all_shortcuts = true;
      draw_minimal_borders = "yes";
      input_delay = 0;
      kitty_mod = "ctrl+shift";

      # Mouse
      mouse_hide_wait = 10;
      url_style = "double";

      # Shhhhh
      enable_audio_bell = false;
      visual_bell_duration = 0;
      window_alert_on_bell = false;
      bell_on_tab = false;
      command_on_bell = "none";

      # Better colors
      term = "xterm-256color";

      # Themes
      # include = "themes/custom-mocha.conf";
      # include = "themes/oxocarbon-dark.conf";
      # terminal_select_modifiers = "alt";

      # Padding
      window_padding_width = 10;

      # Tab Bar
      tab_bar_edge = "top";
      tab_bar_margin_width = 5;
      tab_bar_margin_height = "5 0";
      tab_bar_style = "separator";
      tab_bar_min_tabs = 2;
      # tab_separator = "";
      tab_title_template = "{fmt.fg._5c6370}{fmt.bg.default}{fmt.fg._abb2bf}{fmt.bg._5c6370} {tab.active_oldest_wd} {fmt.fg._5c6370}{fmt.bg.default} ";
      active_tab_title_template = "{fmt.fg._BAA0E8}{fmt.bg.default}{fmt.fg.default}{fmt.bg._BAA0E8} {tab.active_oldest_wd} {fmt.fg._BAA0E8}{fmt.bg.default} ";
      # tab_bar_edge = "bottom";
      # tab_bar_style = "powerline";
      # tab_powerline_style = "slanted";
      # active_tab_title_template = "{index}: {title}";
      # active_tab_font_style = "bold-italic";
      # inactive_tab_font_style = "normal";

      # repaint_delay = 8;
    };
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+s" = "paste_from_selection";
      "ctrl+shift+e" = "open_url";
      "ctrl+shift+=" = "increase_font_size";
      "ctrl+shift+-" = "decrease_font_size";
      "ctrl+shift+backspace" = "restore_font_size";
      "ctrl+shift+up" = "scroll_line_up";
      "ctrl+shift+k" = "scroll_line_up";
      "ctrl+shift+down" = "scroll_line_down";
      "ctrl+shift+j" = "scroll_line_down";
      "ctrl+shift+home" = "scroll_home";
      "ctrl+shift+n" = "new_os_window";
      "ctrl+shift+]" = "next_window";
      "ctrl+shift+[" = "previous_window";
      "ctrl+shift+right" = "next_tab";
      "ctrl+tab" = "next_tab";
      "ctrl+shift+tab" = "previous_tab";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+q" = "close_tab";
    };
  };
  xdg = {
    configFile = {
      #     "kitty/kitty.conf".text = import ./kitty.nix;
      #     "kitty/themes/challenger_deep.conf".text = import ./challenger-deep.nix;
      #     "kitty/themes/dark-decay.conf".text = import ./dark-decay.nix;
      #     "kitty/themes/decayce.conf".text = import ./decayce.nix;
      #     "kitty/themes/lunar.conf".text = import ./lunar.nix;
      #     "kitty/themes/mocha.conf".text = import ./mocha.nix;
      #     "kitty/themes/macchiato.conf".text = import ./macchiato.nix;
      # "kitty/themes/custom-mocha.conf".text = import ./custom-mocha.nix;
      #     "kitty/themes/tokyonight_night.conf".text = import ./tokyonight_night.nix;
      #     "kitty/themes/rose-pine.conf".text = import ./rose-pine.nix;
      #     "kitty/themes/oxocarbon-dark.conf".text = import ./oxocarbon.nix;
    };
  };
}
