{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.myHomeConfig.desktop.hyprland.enable {
    wayland.windowManager.hyprland = {
      settings = {
        window_rule = [
          {
            match.class = "brave-origin";
            workspace = "1";
          }
          {
            match.class = "org.wezfurlong.wezterm";
            workspace = "2";
          }
          {
            match.class = "discord";
            workspace = "3";
          }
        ];
      };
    };
  };
}
