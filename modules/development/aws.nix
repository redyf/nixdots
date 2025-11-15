{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myConfig.development.aws;
in
{
  config = lib.mkIf (config.myConfig.development.enable && cfg.enable) {
    environment.systemPackages = [ pkgs.awscli2 ];
  };
}
