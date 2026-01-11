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
    services.desktopManager.plasma6.enable = true;
  };
}
