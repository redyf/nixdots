{
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.desktop.sway;
in
{
  config = lib.mkIf (config.myConfig.desktop.enable && cfg.enable) {
    programs.sway = {
      enable = true;
      extraOptions = [ "--unsupported-gpu" ];
    };
  };
}
