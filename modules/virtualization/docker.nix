{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.virtualization.docker;
in
{
  options.myConfig.virtualization.docker.enable = lib.mkEnableOption "Docker";

  config = lib.mkIf cfg.enable {
    virtualisation = {
      docker = {
        enable = true;
        autoPrune.enable = true;
      };
    };
  };
}
