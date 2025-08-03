{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix
  ];
  options = {
    niri.enable = lib.mkEnableOption "Enable niri module";
  };
  config = lib.mkIf config.niri.enable {
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];
    home.packages = [ pkgs.xwayland-satellite-unstable ];
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
      settings = {
        xwayland-satellite = {
          enable = true;
        };
        outputs = {
          "DP-3" = {
            mode = {
              width = 1920;
              height = 1080;
              refresh = 164.917;
            };
            scale = 1.0;
            position = {
              x = 0;
              y = 0;
            };
          };
        };

        environment = {
          DISPLAY = ":0";
          ELECTRON_OZONE_PLATFORM_HINT = "auto";
        };
        input = {
          keyboard = {
            repeat-delay = 140;
            repeat-rate = 30;
            xkb = {
              layout = "br";
            };
          };

          touchpad = {
            tap = true;
            accel-profile = "flat";
            natural-scroll = false;
          };

          mouse = {
            accel-profile = "flat";
            natural-scroll = false;
          };
        };
        hotkey-overlay.skip-at-startup = false;
        layer-rules = [
          {
            matches = [
              {
                namespace = "^quickshell-wallpaper$";
              }
            ];
            #place-within-backdrop = true;
          }
          {
            matches = [
              {
                namespace = "^quickshell-overview$";
              }
            ];
            place-within-backdrop = true;
          }
          {
            matches = [
              {
                namespace = "^swww-daemon$";
              }
            ];
            place-within-backdrop = true;
          }
        ];
        window-rules = [
          {
            geometry-corner-radius =
              let
                radius = 10.0;
              in
              {
                bottom-left = radius;
                bottom-right = radius;
                top-left = radius;
                top-right = radius;
              };
            clip-to-geometry = true;
            draw-border-with-background = false;
          }
        ];
        prefer-no-csd = true;

        layout = {
          border = {
            enable = true;
            width = 2;
          };

          preset-column-widths = [
            { proportion = 0.25; }
            { proportion = 0.5; }
            { proportion = 0.75; }
          ];

          default-column-width.proportion = 1.0;

          gaps = 2;

          center-focused-column = "never";
        };
        spawn-at-startup = [
          {
            command = [
              "autostart"
              "xwayland-satellite"
              "obsidian"
            ];
          }

        ];
        animations = {
          enable = true;
          window-open = {
            kind.easing = {
              curve = "ease-out-expo";
              duration-ms = 400;
            };
          };
          window-close.kind.easing = {
            curve = "ease-out-quad";
            duration-ms = 400;
          };
        };
        binds = {
          "Print".action.spawn = [
            "screenshot"
          ];

          "Mod+Print".action.spawn = [
            "screenshot-edit"
          ];

          "Mod+Return".action.spawn = [
            "ghostty"
          ];

          "Mod+O".action.spawn = [
            "obsidian"
          ];

          "Mod+Shift+C".action.spawn = [
            "wallpaper"
          ];

          "Mod+Space".action.spawn = [
            "${pkgs.wofi}/bin/wofi"
            "--show drun"
            "-I -s ~/.config/wofi/style.css DP-3"
          ];

          "Mod+0".action.focus-workspace = 10;
          "Mod+1".action.focus-workspace = 1;
          "Mod+2".action.focus-workspace = 2;
          "Mod+3".action.focus-workspace = 3;
          "Mod+4".action.focus-workspace = 4;
          "Mod+5".action.focus-workspace = 5;
          "Mod+6".action.focus-workspace = 6;
          "Mod+7".action.focus-workspace = 7;
          "Mod+8".action.focus-workspace = 8;
          "Mod+9".action.focus-workspace = 9;

          "Mod+Shift+0".action.move-column-to-workspace = 10;
          "Mod+Shift+1".action.move-column-to-workspace = 1;
          "Mod+Shift+2".action.move-column-to-workspace = 2;
          "Mod+Shift+3".action.move-column-to-workspace = 3;
          "Mod+Shift+4".action.move-column-to-workspace = 4;
          "Mod+Shift+5".action.move-column-to-workspace = 5;
          "Mod+Shift+6".action.move-column-to-workspace = 6;
          "Mod+Shift+7".action.move-column-to-workspace = 7;
          "Mod+Shift+8".action.move-column-to-workspace = 8;
          "Mod+Shift+9".action.move-column-to-workspace = 9;

          "Mod+Comma".action.consume-or-expel-window-left = { };
          "Mod+Period".action.consume-or-expel-window-right = { };

          "Mod+S".action.toggle-window-floating = { };
          "Mod+Shift+S".action.switch-focus-between-floating-and-tiling = { };

          "Mod+H".action.focus-column-left = { };
          "Mod+J".action.focus-window-down = { };
          "Mod+K".action.focus-window-up = { };
          "Mod+L".action.focus-column-right = { };

          "Mod+V".action.toggle-overview = { };

          "Mod+Shift+H".action.move-column-left = { };
          "Mod+Shift+J".action.move-window-down = { };
          "Mod+Shift+K".action.move-window-up = { };
          "Mod+Shift+L".action.move-column-right = { };

          # "Mod+N".action.focus-monitor-left = { };
          # "Mod+M".action.focus-monitor-right = { };

          "Mod+M".action.quit = { };

          "Mod+Shift+N".action.move-column-to-monitor-left = { };
          "Mod+Shift+M".action.move-column-to-monitor-right = { };

          "Mod+Q".action.close-window = { };

          "Mod+R".action.switch-preset-column-width = { };
          "Mod+Shift+R".action.switch-preset-column-width = { };

          "Mod+F".action.maximize-column = { };
          "Mod+Shift+F".action.fullscreen-window = { };

          "Mod+C".action.center-column = { };

          "Mod+Minus".action.set-column-width = "-10%";
          "Mod+Equal".action.set-column-width = "+10%";
        };
      };
    };
  };
}
