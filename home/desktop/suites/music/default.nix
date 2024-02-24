{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.music;
in {
  options.suites.music = with types; {
    enable = mkBoolOpt false "Enable music suite";
  };

  config = mkIf cfg.enable {
    hardware = {
      audio = enabled;
    };
  };
}
