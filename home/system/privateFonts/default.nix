{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:

let
  hasFontFlake = inputs ? font-flake;
  ff = if hasFontFlake then inputs.font-flake.packages.${pkgs.stdenv.hostPlatform.system} else null;
in
{
  options = {
    privateFonts.enable = lib.mkEnableOption "Enable private fonts";
  };
  config = lib.mkIf (config.privateFonts.enable && hasFontFlake) {
    home.packages = [
      ff.tx02
    ];
  };
}
