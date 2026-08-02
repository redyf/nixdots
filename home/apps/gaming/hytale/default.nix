{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    hytale.enable = lib.mkEnableOption "Enable hytale module";
  };
  config = lib.mkIf config.hytale.enable {
    home = {
      packages = [
        inputs.hytale-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
  };
}
