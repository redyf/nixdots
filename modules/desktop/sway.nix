{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.desktop.sway;
in
{
  options.myConfig.desktop.sway.enable = lib.mkEnableOption "sway";

  config = lib.mkIf cfg.enable {
    programs.sway = {
      enable = true;
    };
  };
}
