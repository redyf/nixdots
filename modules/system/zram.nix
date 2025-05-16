{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.zram;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    zramSwap = {
      enable = true;
      memoryPercent = 50;
    };
  };
}
