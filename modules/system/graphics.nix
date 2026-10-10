{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.graphics;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };
}
