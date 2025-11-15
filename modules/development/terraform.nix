{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myConfig.development.terraform;
in
{
  config = lib.mkIf (config.myConfig.development.enable && cfg.enable) {
    environment.systemPackages = [ pkgs.terraform ];
  };
}
