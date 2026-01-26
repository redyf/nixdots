{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myConfig.development.localstack;
in
{
  config = lib.mkIf (config.myConfig.development.enable && cfg.enable) {
    environment.systemPackages = with pkgs; [
      localstack
    ];
  };
}
