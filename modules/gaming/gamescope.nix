{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myConfig.gaming.gamescope;
in
{
  options.myConfig.gaming.gamescope.enable = lib.mkEnableOption "gamescope";

  config = lib.mkIf cfg.enable {
    programs.gamescope = {
      enable = true;
      package = pkgs.gamescope.overrideAttrs (_: {
        NIX_CFLAGS_COMPILE = [ "-fno-fast-math" ];
      });
    };
  };
}
