{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.desktop.kde;
in
{
  options.myConfig.desktop.kde.enable = lib.mkEnableOption "kde";

  config = lib.mkIf cfg.enable {
    services.desktopManager.plasma6.enable = true;
  };
}
