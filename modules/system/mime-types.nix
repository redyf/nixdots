{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.mime-types;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    xdg.mime = {
      enable = true;
      defaultApplications = {
        "text/x-csharp" = "rider.desktop";
        "text/java" = "idea.desktop";
        "text/html" = [ "zen-twilight.desktop" ];
        "x-scheme-handler/http" = [ "zen-twilight.desktop" ];
        "x-scheme-handler/https" = [ "zen-twilight.desktop" ];
        "x-scheme-handler/about" = [ "zen-twilight.desktop" ];
        "x-scheme-handler/unknown" = [ "zen-twilight.desktop" ];
      };
    };
  };
}
