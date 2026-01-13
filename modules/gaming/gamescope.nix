{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myConfig.gaming.gamescope;
in
{
  config = lib.mkIf (config.myConfig.gaming.enable && cfg.enable) {
    programs.gamescope = {
      enable = true;
      package = pkgs.gamescope.overrideAttrs (_: {
        NIX_CFLAGS_COMPILE = [ "-fno-fast-math" ];
      });
    };
  };
}
