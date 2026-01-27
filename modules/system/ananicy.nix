{
  pkgs,
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.ananicy;
in
{
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    services.ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos;
    };
  };
}
