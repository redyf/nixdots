{
  pkgs,
  lib,
  config,
  ...
}:
let
  c = config.lib.stylix.colors.withHashtag;
  mono = config.stylix.fonts.monospace.name;
in
{
  options.myHomeConfig.desktop.wofi.enable = lib.mkEnableOption "wofi";
  config = lib.mkIf config.myHomeConfig.desktop.wofi.enable {
    home = {
      packages = with pkgs; [
        wofi
      ];
    };

    xdg.configFile = {
      "wofi/config" = {
        text = ''
          width=600
          height=400
          show=drun
          prompt=Search...
          filter_rate=100
          allow_markup=true
          no_actions=true
          halign=fill
          orientation=vertical
          content_halign=fill
          insensitive=true
          allow_images=true
          image_size=40
          gtk_dark=true
        '';
      };
      "wofi/style.css" = {
        text = ''
          /* @import ".config/wofi/style.css"; */
          /* @import ".config/wofi/themes/iceberg.css"; */

          window {
            margin: 0px;
            border: 5px solid ${c.base00};
            border-radius: 15px;
            background-color: ${c.base00};
            font-family: "${mono}", "Font Awesome 6 Free Solid";
            font-size: 12px;
          }

          @keyframes gradient_f {
            0% {
              background-position: 0% 200%;
            }
            50% {
              background-position: 200% 0%;
            }
            100% {
              background-position: 400% 200%;
            }
          }

          #input {
            all: unset;
            min-height: 36px;
            padding: 4px 10px;
            margin: 4px;
            border: none;
            color: ${c.base05};
            font-weight: bold;
            background-color: ${c.base01};
            outline: none;
            border-radius: 15px;
            margin: 10px;
            margin-bottom: 2px;
          }

          #inner-box {
            margin: 4px;
            padding: 10px;
            font-weight: bold;
            border-radius: 15px;
          }

          #outer-box {
            margin: 0px;
            padding: 3px;
            border: none;
            border: 5px solid ${c.base00};
            border-radius: 15px;
          }

          #scroll {
            margin-top: 5px;
            border: none;
            border-radius: 15px;
            margin-bottom: 5px;
          }

          #text:selected {
            color: ${c.base00};
            margin: 0px 0px;
            border: none;
            border-radius: 15px;
          }

          #entry {
            margin: 0px 0px;
            border: none;
            border-radius: 15px;
            background-color: transparent;
          }

          #entry:selected {
            margin: 0px 0px;
            border: none;
            border-radius: 15px;
            background: radial-gradient(
              circle,
              ${c.base0D} 0%,
              ${c.base0D} 12%,
              ${c.base0C} 19%,
              ${c.base0E} 20%,
              ${c.base0D} 36%,
              ${c.base07} 48%,
              ${c.base0C} 52%,
              ${c.base07} 59%,
              ${c.base0C} 66%,
              ${c.base07} 68%,
              ${c.base02} 77%,
              ${c.base0D} 78%,
              ${c.base07} 83%,
              ${c.base0D} 100%
            );
            background-size: 400% 400%;
            animation: gradient_f linear infinite;
            animation-delay: 0s;
            animation-fill-mode: forwards;
            animation-duration: 10s;
          }
        '';
      };
      "wofi/menu" = {
        text = ''
          # Config for wofi-wifi-menu

          # position values:
          # 1 2 3
          # 8 0 4
          # 7 6 5
          POSITION=3

          #y-offset
          YOFF=15

          #x-offset
          XOFF=-30

          #fields to be displayed
          FIELDS=SSID,IN-USE,BARS,SECURITY
        '';
      };
      "wofi/executable_wifi" = {
        text = ''
          # Config for wofi-wifi-menu

          # position values:
          # 1 2 3
          # 8 0 4
          # 7 6 5
          POSITION=3

          #y-offset
          YOFF=65

          #x-offset
          XOFF=-40

          #fields to be displayed
          FIELDS=SSID,SECURITY,BARS
        '';
      };
    };
  };
}
