{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.apps.browsers.chrome.enable = lib.mkEnableOption "chrome";
  config = lib.mkIf config.myHomeConfig.apps.browsers.chrome.enable {
    home.packages = [
      pkgs.google-chrome
    ];
  };
}
