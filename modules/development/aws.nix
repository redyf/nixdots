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
  options.myConfig.development.aws.enable = lib.mkEnableOption "aws cli";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.awscli2
      pkgs.ssm-session-manager-plugin
    ];
  };
}
