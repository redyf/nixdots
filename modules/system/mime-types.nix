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
      };
    };
  };
}
