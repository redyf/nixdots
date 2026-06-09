_: {
  wayland.windowManager.hyprland = {
    settings = {
      exec-once = [
        "noctalia-shell"
        "[workspace 4 silent] obsidian"
        "nvidia-settings -a '[gpu:0]/GpuPowerMizerMode=1'"
      ];
    };
  };
}
