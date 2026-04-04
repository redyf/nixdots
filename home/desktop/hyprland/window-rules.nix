_: {
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        "match:class firefox, workspace 1"
        "match:class wezterm, workspace 2"
        "match:class vesktop, workspace 3"
      ];
    };
  };
}
