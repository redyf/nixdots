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
        "text/html" = [ "brave-origin.desktop" ];
        "x-scheme-handler/http" = [ "brave-origin.desktop" ];
        "x-scheme-handler/https" = [ "brave-origin.desktop" ];
        "x-scheme-handler/about" = [ "brave-origin.desktop" ];
        "x-scheme-handler/unknown" = [ "brave-origin.desktop" ];
      };
    };
  };
}
