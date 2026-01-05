{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.desktop.kde;
in
{
  config = lib.mkIf (config.myConfig.desktop.enable && cfg.enable) {
    services.xserver.windowManager.plasma6 = {
      enable = true;
    };
  };
}
