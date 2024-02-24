{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.rice;
in {
  options.suites.rice = with types; {
    enable = mkBoolOpt false "Enable the rice suite";
  };

  config = mkIf cfg.enable {
    rice = {
      btop = enabled;
      cava = enabled;
      nitch = enabled;
    };
  };
}
