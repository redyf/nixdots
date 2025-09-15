{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.services.fstrim;
in
{
  config = lib.mkIf (config.myConfig.services.enable && cfg.enable) {
    services = {
      fstrim.enable = true;
    };
  };
}
