{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    ghostty.enable = lib.mkEnableOption "Enable ghostty module";
  };
  config = lib.mkIf config.ghostty.enable {
    home = {
      packages = with pkgs; [ inputs.ghostty.packages.${system}.default ];
      file = {
        ".config/ghostty/config".text = ''
          # Fonts
          font-family = "UbuntuMono Nerd Font"
          font-size = 16
          font-style = default
          font-style-bold = default
          font-style-italic = default
          font-style-bold-italic = default
          font-feature =
          font-variation = "wght=600"
          font-thicken = true
          bold-is-bright = false

          # adjust-cell-width =
          # adjust-cell-height =
          # adjust-font-baseline =
          # adjust-underline-position =
          # adjust-underline-thickness = 1
          # adjust-strikethrough-position = 1
          # adjust-strikethrough-thickness = 1
          adjust-cursor-thickness = 10

          # Cursor
          # cursor-color =
          # cursor-opacity =
          # cursor-text =
          cursor-style = block
          cursor-style-blink = false
          cursor-click-to-move = false

          # Mouse
          mouse-hide-while-typing = false
          mouse-scroll-multiplier = 1

          # Screen
          background-opacity = 1
          unfocused-split-opacity = 0.7
          fullscreen = false

          # Mappings
          keybind = ctrl+comma=unbind
          keybind = ctrl+alt+up=unbind
          keybind = ctrl+page_down=unbind
          keybind = ctrl+shift+v=paste_from_clipboard
          keybind = shift+insert=paste_from_selection
          keybind = ctrl+shift+a=unbind
          keybind = shift+up=unbind
          keybind = alt+five=unbind
          keybind = super+ctrl+right_bracket=unbind
          keybind = ctrl+shift+plus=increase_font_size:1
          keybind = ctrl+shift+minus=decrease_font_size:1
          keybind = ctrl+shift+o=unbind
          keybind = ctrl+shift+c=copy_to_clipboard
          keybind = ctrl+shift+q=unbind
          keybind = ctrl+shift+n=unbind
          keybind = ctrl+shift+page_down=unbind
          keybind = ctrl+shift+comma=reload_config
          keybind = shift+left=unbind
          keybind = super+ctrl+shift+up=unbind
          keybind = alt+eight=unbind
          keybind = shift+page_up=unbind
          keybind = ctrl+alt+shift+j=unbind
          keybind = ctrl+shift+left=unbind
          keybind = ctrl+shift+w=unbind
          keybind = super+ctrl+shift+equal=unbind
          keybind = shift+end=unbind
          keybind = ctrl+shift+backspace=reset_font_size
          keybind = alt+three=unbind
          keybind = ctrl+shift+j=unbind
          keybind = ctrl+enter=toggle_fullscreen
          keybind = ctrl+page_up=unbind
          keybind = shift+right=unbind
          keybind = ctrl+alt+left=unbind
          keybind = shift+page_down=unbind
          keybind = ctrl+shift+right=unbind
          keybind = ctrl+shift+page_up=unbind
          keybind = alt+nine=unbind
          keybind = ctrl+shift+t=unbind
          keybind = shift+down=unbind
          keybind = super+ctrl+shift+left=unbind
          keybind = alt+two=unbind
          keybind = ctrl+alt+down=unbind
          keybind = super+ctrl+shift+down=unbind
          keybind = super+ctrl+shift+right=unbind
          keybind = ctrl+plus=unbind
          keybind = alt+four=unbind
          keybind = ctrl+shift+e=unbind
          keybind = ctrl+alt+right=unbind
          keybind = alt+f4=unbind
          keybind = alt+one=unbind
          keybind = ctrl+shift+enter=unbind
          keybind = shift+home=unbind
          keybind = super+ctrl+left_bracket=unbind
          keybind = ctrl+shift+i=unbind
          keybind = alt+six=unbind
          keybind = alt+seven=unbind

          # Window
          window-padding-x = 5
          window-padding-y = 5
          # window-padding-balance = false
          # window-inherit-working-directory = true
          # window-inherit-font-size = true
          # window-decoration = true
          # window-theme = auto
          # window-save-state = default
          # window-new-tab-position = current

          # Clipboard (ask, allow or deny)
          clipboard-read = ask
          clipboard-trim-trailing-spaces = true
          clipboard-paste-protection = true
          clipboard-paste-bracketed-safe = true
          copy-on-select = true

          # Close
          confirm-close-surface = true

          # Shell
          shell-integration = zsh
          shell-integration-features = cursor,no-sudo,title

          # Advanced
          # linux-cgroup = single-instance

          # GTK
          gtk-single-instance = desktop
          gtk-titlebar = false
          gtk-tabs-location = top
          gtk-wide-tabs = true

          # Scheme: Oxocarbon Dark
          # Generated by Ghostty Base16 Converter
          background = 161616
          foreground = f2f4f8

          selection-background = 393939
          selection-foreground = 161616

          palette = 0=#161616
          palette = 1=#3ddbd9
          palette = 2=#33b1ff
          palette = 3=#ee5396
          palette = 4=#42be65
          palette = 5=#be95ff
          palette = 6=#ff7eb6
          palette = 7=#f2f4f8
          palette = 8=#525252
          palette = 9=#3ddbd9
          palette = 10=#33b1ff
          palette = 11=#ee5396
          palette = 12=#42be65
          palette = 13=#be95ff
          palette = 14=#ff7eb6
          palette = 15=#08bdba
          palette = 16=#78a9ff
          palette = 17=#82cfff
          palette = 18=#262626
          palette = 19=#393939
          palette = 20=#dde1e6
          palette = 21=#ffffff
        '';
      };
    };
  };
}
