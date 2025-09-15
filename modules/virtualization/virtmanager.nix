{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.virtualization.virtmanager;
in
{
  config = lib.mkIf (config.myConfig.virtualization.enable && cfg.enable) {
    programs.virt-manager.enable = true;
  };
}
