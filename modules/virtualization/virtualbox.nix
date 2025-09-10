{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myConfig.virtualization.virtualbox;
in
{
  config = lib.mkIf (config.myConfig.virtualization.enable && cfg.enable) {
    programs.virt-manager.enable = true;
    virtualisation = {
      virtualbox = {
        host = {
          enable = true;
          enableExtensionPack = true;
        };
      };
    };
  };
}
