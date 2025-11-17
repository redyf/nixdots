{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.jackett;
in
{
  config = lib.mkIf (config.myConfig.services.enable && cfg.enable) {
    services = {
      jackett = {
        enable = true;
      };
    };
  };
}
