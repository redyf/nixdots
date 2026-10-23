# Home Manager settings for the `desktop` host, whatever the user.
# Imported by lib/mkHome.nix for every "<user>@desktop" configuration.
_: {
  # Monitor layout: DP-1 main, HDMI-A-2 rotated on the right.
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        {
          output = "DP-1";
          mode = "1920x1080@180";
          position = "0x0";
          scale = "1";
        }
        {
          output = "HDMI-A-2";
          mode = "1920x1080@119.98";
          position = "1920x0";
          scale = "1";
          transform = 1;
        }
      ];

      workspace_rule = [
        {
          workspace = "1";
          monitor = "DP-1";
        }
        {
          workspace = "2";
          monitor = "DP-1";
        }
        {
          workspace = "3";
          monitor = "HDMI-A-2";
        }
        {
          workspace = "4";
          monitor = "HDMI-A-2";
        }
      ];
    };
  };
}
