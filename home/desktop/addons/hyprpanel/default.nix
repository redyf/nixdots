{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];
  options = {
    hyprpanel.enable = lib.mkEnableOption "Enable hyprpanel module";
  };
  config = lib.mkIf config.hyprpanel.enable {
    programs.hyprpanel = {
      enable = true;
      systemd.enable = true;
      hyprland.enable = true;
      theme = "catppuccin_mocha";
      overlay.enable = true;
      settings = {
        bar = {
          launcher.autoDetectIcon = true;
          # launcher.icon = " ";
          workspaces.show_icons = true;
        };
        menus = {
          clock = {
            time = {
              military = true;
              hideSeconds = true;
            };
            weather.unit = "metric";
          };
          dashboard = {
            directories.enabled = false;
            stats.enable_gpu = true;
          };
        };
        theme = {
          bar = {
            transparent = false;
          };
          font = {
            name = "CaskaydiaCove NF";
            size = "12px";
          };
        };
      };
    };
  };
}
