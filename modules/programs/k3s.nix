{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.programs.k3s;
in
{
  config = lib.mkIf (config.myConfig.programs.enable && cfg.enable) {
    services.k3s = {
      enable = true;
    };
  };
}
