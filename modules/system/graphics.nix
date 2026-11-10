{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.graphics;
in
{
  options.myConfig.system.graphics.enable =
    lib.mkEnableOption "hardware.graphics (GPU acceleration, 32-bit included)";

  config = lib.mkIf cfg.enable {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };
}
