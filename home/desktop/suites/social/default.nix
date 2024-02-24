{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.social;
in {
  options.suites.social = with types; {
    enable = mkBoolOpt false "Enable the social suite";
  };

  config = mkIf cfg.enable {
    apps = {
      discord = enabled;
    };
  };
}
