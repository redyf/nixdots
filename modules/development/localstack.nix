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
  options.myConfig.development.localstack.enable = lib.mkEnableOption "localstack";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      localstack
    ];
  };
}
