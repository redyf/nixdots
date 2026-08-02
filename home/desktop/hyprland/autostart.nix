{
  lib,
  ...
}:
{
  wayland.windowManager.hyprland = {
    settings = {
      # exec-once (hyprlang) -> evento hyprland.start
      on = {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
              hl.exec_cmd("noctalia-shell")
              hl.exec_cmd("nvidia-settings -a '[gpu:0]/GpuPowerMizerMode=1'")
              hl.exec_cmd("nvibrant 0 512 700 0")
              hl.exec_cmd("obsidian")
            end
          '')
        ];
      };

      # era: exec-once "[workspace 4 silent] obsidian"
      window_rule = [
        {
          match.class = "obsidian";
          workspace = "4";
        }
      ];
    };
  };
}
