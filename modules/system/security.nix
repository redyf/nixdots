{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.security;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    security = {
      sudo = {
        enable = true;
      };
      polkit.enable = true;
    };
  };
}
