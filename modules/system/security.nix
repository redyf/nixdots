{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.security;
in
{
  options.myConfig.system.security.enable = lib.mkEnableOption "security";

  config = lib.mkIf cfg.enable {
    security = {
      polkit.enable = true;
    };
  };
}
