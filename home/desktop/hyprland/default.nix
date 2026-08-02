{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./animations.nix
    ./autostart.nix
    ./binds.nix
    ./decoration.nix
    ./misc.nix
    ./monitors.nix
    ./screenshot.nix
    ./window-rules.nix
  ];
  options = {
    hyprland.enable = lib.mkEnableOption "Enable hyprland module";
  };
  config = lib.mkIf config.hyprland.enable {
    xdg.portal.config.common.default = [ "hyprland" ];

    home.packages = with pkgs; [
      grim
      slurp
      swappy
      wl-clipboard
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      configType = "lua";
      systemd.variables = [ "--all" ];
      xwayland.enable = true;
      settings = {
        # $mainMod -> variável local Lua (usada nos binds)
        mod = {
          _var = "SUPER";
        };

        env = [
          {
            _args = [
              "ELECTRON_OZONE_PLATFORM_HINT"
              "auto"
            ];
          }
        ];

        config = {
          xwayland = {
            force_zero_scaling = true;
          };

          input = {
            kb_layout = "us";
            kb_variant = "intl";

            follow_mouse = 1;
            mouse_refocus = false;
            repeat_delay = 140;
            repeat_rate = 30;
            numlock_by_default = true;
            accel_profile = "flat";
            sensitivity = -0.4;
            force_no_accel = false;
            touchpad = {
              natural_scroll = true;
              tap_to_click = true;
              drag_lock = 1;
            };
          };
        };
      };
    };
  };
}
