{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.time;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    time.timeZone = "America/Bahia";
  };
}
