{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.apps.browsers.vivaldi.enable = lib.mkEnableOption "vivaldi";
  config = lib.mkIf config.myHomeConfig.apps.browsers.vivaldi.enable {
    home.packages = [
      pkgs.vivaldi
    ];
  };
}
