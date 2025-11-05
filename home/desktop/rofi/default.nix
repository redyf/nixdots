{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    rofi.enable = lib.mkEnableOption "Enable rofi module";
  };
  config = lib.mkIf config.rofi.enable {
    home.packages = with pkgs; [
      rofi
      rofi-emoji
    ];
    xdg.configFile."rofi/config.rasi" = {
      text = ''
        configuration {
          scroll-method: 1;
          scrollbar: true;
          show-icons: true;
          display-run: "Run ";
          display-drun: "Open ";
          display-emoji: "Emoji ";
          drun-display-format: "{icon} {name}";
          modi: "run,drun";
        }

        * {
            background: #1e1e2e;
            foreground: #cdd6f4;
            select: #585b70;

            pink: #f5c2e7;
            purple: #cba6f7;
            red: #f38ba8;
            orange: #fab387;
            yellow: #f9e2af;
            green: #a6e3a1;
            blue: #89b4fa;
            gray: #45475a;

            active-background: @select;
            urgent-background: @red;
            urgent-foreground: @background;
            selected-background: @active-background;
            selected-urgent-background: @urgent-background;
            selected-active-background: @active-background;
            bordercolor: @select;
            font: "JetbrainsMono Nerd Font 15";
        }

        #window {
            background-color: @background;
            border:           3;
            border-radius:    6;
            border-color:     @bordercolor;
            padding:          15;
            width:            600px;
        }
        #listview {
            lines:        6;
            fixed-height: 0;
            border:       0px;
            spacing:      2px ;
            padding:      2px 0px 0px ;
        }

        #element {
            border:        0;
            border-radius: 8px;
            padding:       3px;
        }
        #element.normal.normal {
            background-color: @background;
            text-color:       @foreground;
        }
        #element.alternate.normal {
            background-color: @background;
            text-color:       @foreground;
        }
        #element.selected.normal {
            background-color: @selected-background;
            text-color:       @foreground;
        }
        element-text, element-icon {
            size:             45px;
            background-color: inherit;
            text-color:       inherit;
        }

        #scrollbar {
            width:        2px ;
            border:       0;
            handle-width: 8px ;
            padding:      0;
            handle-color: @select;
        }

        #inputbar {
            children:   [ prompt, textbox-prompt-colon, entry ];
            spacing:       0;
            padding:       15px;
            border:        3px;
            border-radius: 6px;
            border-color:  @bordercolor;
        }
        #prompt {
            spacing:    0;
            text-color: @foreground;
        }
        #textbox-prompt-colon {
            expand:     false;
            str:        ">";
            margin:     0px 0.3em 0em 0em ;
            text-color: @foreground;
        }
        #entry {
            spacing:    0;
            text-color: @foreground;
        }
      '';
    };
  };
}
