{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.video;
in {
  options.suites.video = with types; {
    enable = mkBoolOpt false "Enable video suite";
  };

  config = mkIf cfg.enable {
    apps = {
      obs = enabled;
    };
  };
}
