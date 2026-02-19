{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.tuned;
in
{
  config = lib.mkIf (config.myConfig.services.enable && cfg.enable) {
    services = {
      tuned = {
        enable = true;
      };
    };
  };
}
