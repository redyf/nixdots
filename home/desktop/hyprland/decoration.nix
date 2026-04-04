{
  lib,
  ...
}:
let
  tokyonight_border = "rgba(7aa2f7ee) rgba(87aaf8ee) 45deg";
  tokyonight_background = "rgba(32344aaa)";
  catppuccin_macchiato_active_border = "rgb(8aadf4) rgb(24273A) rgb(24273A) rgb(8aadf4) 45deg";
  catppuccin_macchiato_inactive_border = "rgb(24273A) rgb(24273A) rgb(24273A) rgb(24273A) 45deg";
  opacity = "0.95";
in
{
  wayland.windowManager.hyprland = {
    settings = {

      cursor = {
        enable_hyprcursor = true;
        no_hardware_cursors = false;
      };

      general = {
        gaps_in = 2;
        gaps_out = 0;
        border_size = 3;
        layout = "scrolling";
        allow_tearing = true;
        "col.active_border" = lib.mkDefault "${catppuccin_macchiato_active_border}";
        "col.inactive_border" = lib.mkDefault "${catppuccin_macchiato_inactive_border}";
      };

      scrolling = {
        column_width = 1.0;
      };

      decoration = {
        rounding = 0;
        shadow = {
          enabled = false;
          ignore_window = true;
          range = 20;
          render_power = 1;
        };
        blur = {
          enabled = false;
          size = 4;
          passes = 2;
          new_optimizations = true;
          ignore_opacity = true;
          noise = 1.17e-2;
          contrast = 1.3;
          brightness = 1;
          xray = true;
        };
      };
    };
  };
}
