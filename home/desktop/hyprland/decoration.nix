{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.myHomeConfig.desktop.hyprland.enable {
    wayland.windowManager.hyprland = {
      settings = {
        config = {
          cursor = {
            enable_hyprcursor = true;
            no_hardware_cursors = 0;
          };

          general = {
            gaps_in = 2;
            gaps_out = 0;
            border_size = 3;
            layout = "dwindle";
            allow_tearing = true;
            col.active_border = {
              colors = [
                "rgb(${config.lib.stylix.colors.base0D})"
                "rgb(${config.lib.stylix.colors.base00})"
                "rgb(${config.lib.stylix.colors.base00})"
                "rgb(${config.lib.stylix.colors.base0D})"
              ];
              angle = 45;
            };
            col.inactive_border = {
              colors = [ "rgb(${config.lib.stylix.colors.base00})" ];
              angle = 0;
            };
          };

          scrolling = {
            column_width = 1.0;
          };

          decoration = {
            rounding = 0;
            shadow = {
              enabled = false;
              range = 20;
              render_power = 1;
            };
            blur = {
              enabled = false;
              size = 4;
              passes = 2;
              new_optimizations = true;
              ignore_opacity = true;
              noise = 0.0117;
              contrast = 1.3;
              brightness = 1;
              xray = true;
            };
          };
        };
      };
    };
  };
}
