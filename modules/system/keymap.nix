{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.keymap;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    console = {
      keyMap = "br-abnt2";
    };
  };
}
