{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.virtualization.docker;
in
{
  config = lib.mkIf (config.myConfig.virtualization.enable && cfg.enable) {
    virtualisation = {
      docker.rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}
