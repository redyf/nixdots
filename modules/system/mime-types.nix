{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.mime-types;
  browser = [ config.myConfig.system.environment.defaultBrowser.desktopFile ];
in
{
  options.myConfig.system.mime-types.enable = lib.mkEnableOption "mime types";

  config = lib.mkIf cfg.enable {
    xdg.mime = {
      enable = true;
      defaultApplications = {
        "text/x-csharp" = "rider.desktop";
        "text/java" = "idea.desktop";
        "text/html" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/about" = browser;
        "x-scheme-handler/unknown" = browser;
      };
    };
  };
}
