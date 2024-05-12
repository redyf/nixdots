_: let
  catppuccin = import ./catppuccin.nix;
  rose-pine = import ./rose-pine.nix;
  tokyonight = import ./tokyonight.nix;
in {
  programs.alacritty = {
    enable = true;
    settings = {
      inherit (catppuccin) colors;
      cursor = {
        style = {
          blinking = "Never";
        };
      };
      font = {
        size = 16;
        normal = {
          family = "Fira Mono Nerd Font";
          style = "Medium Italic";
        };
        bold = {
          family = "Fira Mono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "Fira Mono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "Fira Mono Nerd Font";
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
        opacity = 0.95;
        decorations = "none";
        padding = {
          x = 10;
          y = 10;
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
        {
          key = "Paste";
          action = "Paste";
        }
        {
          key = "Copy";
          action = "Copy";
        }
        # { key = "L"; mods = "Control"; action = "ClearLogNotice"; }
        # { key = "L"; mods = "Control"; chars = "\x0c"; }
        {
          key = "PageUp";
          mods = "Shift";
          action = "ScrollPageUp";
          mode = "~Alt";
        }
        {
          key = "PageDown";
          mods = "Shift";
          action = "ScrollPageDown";
          mode = "~Alt";
        }
        {
          key = "Home";
          mods = "Shift";
          action = "ScrollToTop";
          mode = "~Alt";
        }
        {
          key = "End";
          mods = "Shift";
          action = "ScrollToBottom";
          mode = "~Alt";
        }
      ];
    };
  };
}
