{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.time;
in
{
  options.myConfig.system.time.enable = lib.mkEnableOption "time";

  config = lib.mkIf cfg.enable {
    time.timeZone = "America/Bahia";
  };
}
