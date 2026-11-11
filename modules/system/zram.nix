{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.zram;
in
{
  options.myConfig.system.zram.enable = lib.mkEnableOption "zram";

  config = lib.mkIf cfg.enable {
    zramSwap = {
      enable = true;
      memoryPercent = 50;
    };
  };
}
