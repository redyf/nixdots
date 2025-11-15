{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myConfig.development.ansible;
in
{
  config = lib.mkIf (config.myConfig.development.enable && cfg.enable) {
    environment.systemPackages = [ pkgs.ansible ];
  };
}
