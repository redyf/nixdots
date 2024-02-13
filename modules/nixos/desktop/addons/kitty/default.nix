{ options
, config
, pkgs
, lib
, inputs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.addons.kitty;
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme}) colors;
in
{
  options.desktop.addons.kitty = with types; {
    enable = mkBoolOpt false "Enable or disable the kitty terminal.";
  };

  config =
    mkIf cfg.enable
      {
        environment.systemPackages = with pkgs; [ kitty ];
        home.extraOptions.programs.kitty = {
          enable = true;
          shellIntegration = {
            enableZshIntegration = true;
            mode = "no-cursor";
          };
          theme = "Catppuccin-Mocha";
          font = {
            name = "MonoLisa-Medium";
            size = 14;
          };
          settings = {
            bold_font = "MonoLisa-Bold";
            italic_font = "MonoLisa-MediumItalic";
            bold_italic_font = "MonoLisa-BoldItalic";
            cell_height = "100%";
            cell_width = "100%";

            # modify_font underline_position 4
            # modify_font underline_thickness 150%
            # text_composition_strategy = "legacy";

            # Background
            background_opacity = "0.98";

            # Cursor
            cursor_shape = "block";
            cursor_blink_interval = 0;

            # Don't ask for confirmation when closing a tab.
            confirm_os_window_close = 0;
            disable_ligatures = "never";

            copy_on_select = "clipboard";
            # terminal_select_modifiers = "alt";

            # Mouse
            mouse_hide_wait = 10;
            url_style = "double";

            # Shhhhh
            enable_audio_bell = false;
            visual_bell_duration = 0;
            window_alert_on_bell = false;
            bell_on_tab = false;
            command_on_bell = "none";

            term = "xterm-256color";

            clear_all_shortcuts = true;

            # Themes
            # include = themes/mocha.conf;

            # Padding
            window_padding_width = 10;

            # Tab Bar
            tab_bar_edge = "top";
            tab_bar_margin_width = 5;
            tab_bar_margin_height = "5 0";
            tab_bar_style = "separator";
            tab_bar_min_tabs = 2;
            tab_separator = "";
            tab_title_template = "{fmt.fg._5c6370}{fmt.bg.default}{fmt.fg._abb2bf}{fmt.bg._5c6370} {tab.active_oldest_wd} {fmt.fg._5c6370}{fmt.bg.default} ";
            active_tab_title_template = "{fmt.fg._BAA0E8}{fmt.bg.default}{fmt.fg.default}{fmt.bg._BAA0E8} {tab.active_oldest_wd} {fmt.fg._BAA0E8}{fmt.bg.default} ";

            # tab_bar_edge = "bottom";
            # tab_bar_style = "powerline";
            # tab_powerline_style = "slanted";
            # active_tab_title_template = "{index}: {title}";
            # active_tab_font_style = "bold-italic";
            # inactive_tab_font_style = "normal";

            # input_delay = 1;
            # repaint_delay = 8;
            # sync_to_monitor = "no";
          };
        };
      };
  # home.extraOptions.xdg = {
  #   configFile = {
  #     "kitty/kitty.conf".text = import ./kitty.nix;
  #     "kitty/themes/challenger_deep.conf".text = import ./challenger-deep.nix;
  #     "kitty/themes/dark-decay.conf".text = import ./dark-decay.nix;
  #     "kitty/themes/decayce.conf".text = import ./decayce.nix;
  #     "kitty/themes/lunar.conf".text = import ./lunar.nix;
  #     "kitty/themes/mocha.conf".text = import ./mocha.nix;
  #     "kitty/themes/macchiato.conf".text = import ./macchiato.nix;
  #     "kitty/themes/tokyonight_night.conf".text = import ./tokyonight_night.nix;
  #     "kitty/themes/rose-pine.conf".text = import ./rose-pine.nix;
  #   };
  # };
}
