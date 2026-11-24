# Home Manager settings for the `desktop` host, whatever the user.
{ config, lib, ... }:
{
  # Monitor layout: DP-3 main, HDMI-A-3 rotated on the right. The i3 (X11)
  # equivalent is xserver.displaySetup in configuration.nix.
  xdg.configFile = lib.mkIf config.myHomeConfig.desktop.sway.enable {
    "sway/config".text = lib.mkAfter ''
      output DP-3 mode 1920x1080@180Hz position 0 0
      output HDMI-A-3 mode 1920x1080@144Hz position 1920 0 transform 90
      bindsym Control+Print exec grim -o DP-3 ~/Pictures/screenshot.png
    '';
  };

  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        {
          _args = [
            "CTRL + Print"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"grim -o DP-3 ~/Pictures/screenshot.png\")")
          ];
        }
      ];

      monitor = [
        {
          output = "DP-3";
          mode = "1920x1080@180";
          position = "0x0";
          scale = "1";
        }
        {
          output = "HDMI-A-3";
          mode = "1920x1080@144";
          position = "1920x0";
          scale = "1";
          transform = 1;
        }
      ];

      workspace_rule = [
        {
          workspace = "1";
          monitor = "DP-3";
          default = true;
        }
        {
          workspace = "2";
          monitor = "DP-3";
        }
        {
          workspace = "3";
          monitor = "HDMI-A-3";
          default = true;
        }
        {
          workspace = "4";
          monitor = "HDMI-A-3";
        }
      ];
    };
  };
}
