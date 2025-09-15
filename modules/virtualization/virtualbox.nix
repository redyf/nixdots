{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.virtualization.virtualbox;
in
{
  config = lib.mkIf (config.myConfig.virtualization.enable && cfg.enable) {
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
