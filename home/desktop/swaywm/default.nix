{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    swaywm.enable = lib.mkEnableOption "Enable sway module";
  };
  config = lib.mkIf config.swaywm.enable {
    wayland.windowManager.sway = {
      enable = true;
      config = {
        terminal = "ghostty";
      };
    };
  };
}
