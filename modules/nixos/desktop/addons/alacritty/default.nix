{ options
, config
, pkgs
, lib
, inputs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.addons.alacritty;
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme}) colors;
in
{
  options.desktop.addons.alacritty = with types; {
    enable = mkBoolOpt false "Enable or disable the alacritty terminal.";
  };

  config = mkIf cfg.enable {
    home.extraOptions.programs.alacritty = {
      enable = true;
      settings = {
        cursor = {
          style = {
            blinking = "Never";
          };
        };
        font = {
          size = 16;
          normal = {
            family = "FiraMono Nerd Font";
            style = "Medium";
          };
          bold = {
            family = "FiraMono Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "FiraMono Nerd Font";
            style = "Italic";
          };
          bold_italic = {
            family = "FiraMono Nerd Font";
            style = "Bold Italic";
          };
          offset = {
            x = 0;
            y = 0;
          };
          glyph_offset = {
            x = 0;
            y = 0;
          };
        };
        window = {
          opacity = 0.9;
          decorations = "none";
          padding = {
            x = 10;
            y = 10;
          };
        };
        colors = {
          primary = {
            foreground = "#e0def4";
            background = "#191724";
            dim_foreground = "#908caa";
            bright_foreground = "#e0def4";
          };
          cursor = {
            text = "#e0def4";
            cursor = "#524f67";
          };
          vi_mode_cursor = {
            text = "#e0def4";
            cursor = "#524f67";
          };
          search = {
            matches = {
              foreground = "#908caa";
              background = "#26233a";
            };
            focused_match = {
              foreground = "#191724";
              background = "#ebbcba";
            };
          };
          hints = {
            start = {
              foreground = "#908caa";
              background = "#1f1d2e";
            };
            end = {
              foreground = "#6e6a86";
              background = "#1f1d2e";
            };
          };
          line_indicator = {
            foreground = "None";
            background = "None";
          };
          footer_bar = {
            foreground = "#e0def4";
            background = "#1f1d2e";
          };
          selection = {
            text = "#e0def4";
            background = "#403d52";
          };
          normal = {
            black = "#26233a";
            red = "#eb6f92";
            green = "#31748f";
            yellow = "#f6c177";
            blue = "#9ccfd8";
            magenta = "#c4a7e7";
            cyan = "#ebbcba";
            white = "#e0def4";
          };
          bright = {
            black = "#6e6a86";
            red = "#eb6f92";
            green = "#31748f";
            yellow = "#f6c177";
            blue = "#9ccfd8";
            magenta = "#c4a7e7";
            cyan = "#ebbcba";
            white = "#e0def4";
          };
          dim = {
            black = "#6e6a86";
            red = "#eb6f92";
            green = "#31748f";
            yellow = "#f6c177";
            blue = "#9ccfd8";
            magenta = "#c4a7e7";
            cyan = "#ebbcba";
            white = "#e0def4";
          };
        };
        keyboard.bindings = [
          {
            key = "V";
            mods = "Control|Shift";
            action = "Paste";
          }
          {
            key = "C";
            mods = "Control|Shift";
            action = "Copy";
          }
          {
            key = "Insert";
            mods = "Shift";
            action = "PasteSelection";
          }
          {
            key = "Key0";
            mods = "Control";
            action = "ResetFontSize";
          }
          {
            key = "Equals";
            mods = "Control";
            action = "IncreaseFontSize";
          }
          {
            key = "Minus";
            mods = "Control";
            action = "DecreaseFontSize";
          }
          { key = "Paste"; action = "Paste"; }
          { key = "Copy"; action = "Copy"; }
          { key = "L"; mods = "Control"; action = "ClearLogNotice"; }
          { key = "L"; mods = "Control"; chars = "\x0c"; }
          {
            key = "PageUp";
            mods = "Shift";
            action = "ScrollPageUp";
            mode = "~Alt";
          }
          { key = "PageDown"; mods = "Shift"; action = "ScrollPageDown"; mode = "~Alt"; }
          { key = "Home"; mods = "Shift"; action = "ScrollToTop"; mode = "~Alt"; }
          { key = "End"; mods = "Shift"; action = "ScrollToBottom"; mode = "~Alt"; }
        ];
      };
    };
  };
}
