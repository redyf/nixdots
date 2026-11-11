{
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.apps.browsers.firefox.enable = lib.mkEnableOption "firefox";
  config = lib.mkIf config.myHomeConfig.apps.browsers.firefox.enable {
    programs.firefox = {
      enable = true;
      configPath = "${config.xdg.configHome}/mozilla/firefox";
    };
  };
}
