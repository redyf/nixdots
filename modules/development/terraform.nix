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
  options.myConfig.development.terraform.enable = lib.mkEnableOption "Terraform";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.terraform ];
  };
}
