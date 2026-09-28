{
  lib,
  ...
}:
{
  wayland.windowManager.hyprland = {
    settings = {
      on = {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
              -- hl.exec_cmd("noctalia-shell")
              -- hl.exec_cmd("caelestia-shell")
              -- hl.exec_cmd("wl-paste --type text --watch cliphist store")
              -- hl.exec_cmd("wl-paste --type image --watch cliphist store")
              -- hl.exec_cmd("systemctl --user enable --now easyeffects")
              hl.exec_cmd("nvidia-settings -a '[gpu:0]/GpuPowerMizerMode=1'")
              hl.exec_cmd("nvibrant 0 512 700 0")
              hl.exec_cmd("obsidian")
            end
          '')
        ];
      };

      window_rule = [
        {
          match.class = "obsidian";
          workspace = "3";
        }
        {
          match.class = "slack";
          workspace = "4";
        }
      ];
    };
  };
}
