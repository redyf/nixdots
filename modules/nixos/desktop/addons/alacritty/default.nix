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
          size = 15;
          normal = {
            family = "JetBrainsMono Nerd Font";
            style = "Medium";
          };
          bold = {
            family = "JetBrainsMono Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "JetBrainsMono Nerd Font";
            style = "Italic";
          };
          bold_italic = {
            family = "JetBrainsMono Nerd Font";
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
          opacity = 0.98;
          decorations = "none";
          padding = {
            x = 10;
            y = 10;
          };
        };
        colors = {
          primary = {
            background = "#1E1E2E";
            foreground = "#CDD6F4";
            dim_foreground = "#CDD6F4";
            bright_foreground = "#CDD6F4";
          };
          cursor = {
            text = "#1E1E2E";
            cursor = "#F5E0DC";
          };
          vi_mode_cursor = {
            text = "#1E1E2E";
            cursor = "#B4BEFE";
          };
          search = {
            matches = {
              foreground = "#1E1E2E";
              background = "#A6ADC8";
            };
            focused_match = {
              foreground = "#1E1E2E";
              background = "#A6E3A1";
            };
          };
          footer_bar = {
            foreground = "#1E1E2E";
            background = "#A6ADC8";
          };
          hints = {
            start = {
              foreground = "#1E1E2E";
              background = "#F9E2AF";
            };
            end = {
              foreground = "#1E1E2E";
              background = "#A6ADC8";
            };
          };
          selection = {
            text = "#1E1E2E";
            background = "#F5E0DC";
          };
          normal = {
            black = "#45475A";
            red = "#F38BA8";
            green = "#A6E3A1";
            yellow = "#F9E2AF";
            blue = "#89B4FA";
            magenta = "#F5C2E7";
            cyan = "#94E2D5";
            white = "#BAC2DE";
          };
          bright = {
            black = "#585B70";
            red = "#F38BA8";
            green = "#A6E3A1";
            yellow = "#F9E2AF";
            blue = "#89B4FA";
            magenta = "#F5C2E7";
            cyan = "#94E2D5";
            white = "#A6ADC8";
          };
          dim = {
            black = "#45475A";
            red = "#F38BA8";
            green = "#A6E3A1";
            yellow = "#F9E2AF";
            blue = "#89B4FA";
            magenta = "#F5C2E7";
            cyan = "#94E2D5";
            white = "#BAC2DE";
          };
          indexed_colors = [
            {
              index = 17;
              color = "#F5E0DC";
            }
            {
              index = 16;
              color = "#FAB387";
            }
          ];
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
          # { key = "L"; mods = "Control"; action = "ClearLogNotice"; }
          # { key = "L"; mods = "Control"; chars = "\x0c"; }
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
      # colors = {
      #   primary = {
      #     # mountain
      #     # foreground = "#f0f0f0";
      #     # background = "#0f0f0f";
      #     # rose-pine
      #     # foreground = "#e0def4";
      #     # background = "#191724";
      #     # dim_foreground = "#908caa";
      #     # bright_foreground = "#e0def4";
      #   };
      #   # rose-pine
      #   cursor = {
      #     text = "#e0def4";
      #     cursor = "#524f67";
      #   };
      #   vi_mode_cursor = {
      #     text = "#e0def4";
      #     cursor = "#524f67";
      #   };
      #   search = {
      #     matches = {
      #       foreground = "#908caa";
      #       background = "#26233a";
      #     };
      #     focused_match = {
      #       foreground = "#191724";
      #       background = "#ebbcba";
      #     };
      #   };
      #   hints = {
      #     start = {
      #       foreground = "#908caa";
      #       background = "#1f1d2e";
      #     };
      #     end = {
      #       foreground = "#6e6a86";
      #       background = "#1f1d2e";
      #     };
      #   };
      #   line_indicator = {
      #     foreground = "None";
      #     background = "None";
      #   };
      #   footer_bar = {
      #     foreground = "#e0def4";
      #     background = "#1f1d2e";
      #   };
      #   selection = {
      #     text = "#e0def4";
      #     background = "#403d52";
      #   };
      #   normal = {
      #     # mountain
      #     # black = "#262626";
      #     # red = "#ac8a8c";
      #     # green = "#8aac8b";
      #     # yellow = "#aca98a";
      #     # blue = "#8f8aac";
      #     # magenta = "#ac8aac";
      #     # cyan = "#8aacac";
      #     # white = "#e7e7e7";
      #     # rose-pine
      #     # black = "#26233a";
      #     # red = "#eb6f92";
      #     # green = "#31748f";
      #     # yellow = "#f6c177";
      #     # blue = "#9ccfd8";
      #     # magenta = "#c4a7e7";
      #     # cyan = "#ebbcba";
      #     # white = "#e0def4";
      #   };
      #   bright = {
      #     # mountain
      #     # black = "#4c4c4c";
      #     # red = "#c49ea0";
      #     # green = "#9ec49f";
      #     # yellow = "#c4c19e";
      #     # blue = "#a39ec4";
      #     # magenta = "#c49ec4";
      #     # cyan = "#9ec3c4";
      #     # white = "#f5f5f5";
      #     # rose-pine
      #     # black = "#6e6a86";
      #     # red = "#eb6f92";
      #     # green = "#31748f";
      #     # yellow = "#f6c177";
      #     # blue = "#9ccfd8";
      #     # magenta = "#c4a7e7";
      #     # cyan = "#ebbcba";
      #     # white = "#e0def4";
      #   };
      #   dim = {
      #     # rose-pine
      #     black = "#6e6a86";
      #     red = "#eb6f92";
      #     green = "#31748f";
      #     yellow = "#f6c177";
      #     blue = "#9ccfd8";
      #     magenta = "#c4a7e7";
      #     cyan = "#ebbcba";
      #     white = "#e0def4";
      #   };
      # };
    };
  };
}
