_: {
  wayland.windowManager.hyprland = {
    settings = {
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
        }
        {
          workspace = "2";
          monitor = "DP-3";
        }
        {
          workspace = "3";
          monitor = "HDMI-A-3";
        }
        {
          workspace = "4";
          monitor = "HDMI-A-3";
        }
      ];
    };
  };
}
