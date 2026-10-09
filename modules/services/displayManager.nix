{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.displayManager;
in
{
  config = lib.mkIf (config.myConfig.services.enable && cfg.enable) {
    services.displayManager = {
      enable = true;
      ly.enable = true;
    };
  };
}
