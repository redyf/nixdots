{
  pkgs,
  inputs,
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
    home.packages = with pkgs; [
      grim
      slurp
      swappy
      wl-clipboard
      inputs.nvibrant.packages.${stdenv.hostPlatform.system}.nvibrant
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      systemd.variables = [ "--all" ];
      xwayland.enable = true;
      settings = {
        "$mainMod" = "SUPER";

        env = [
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
        ];

        xwayland = {
          force_zero_scaling = true;
        };

        input = {
          kb_layout = "br";
          kb_variant = "";
          kb_model = "";
          kb_options = "";
          kb_rules = "";

          follow_mouse = 1;
          mouse_refocus = false;
          repeat_delay = 140;
          repeat_rate = 30;
          numlock_by_default = 1;
          accel_profile = "flat";
          sensitivity = -0.4;
          force_no_accel = false;
          touchpad = {
            natural_scroll = 1;
          };
        };
      };
    };
  };
}
