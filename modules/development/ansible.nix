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
  options.myConfig.development.ansible.enable = lib.mkEnableOption "Ansible";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.ansible ];
  };
}
