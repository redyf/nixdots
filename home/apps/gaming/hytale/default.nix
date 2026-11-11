{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.apps.gaming.hytale.enable = lib.mkEnableOption "hytale";
  config = lib.mkIf config.myHomeConfig.apps.gaming.hytale.enable {
    home = {
      packages = [
        inputs.hytale-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
  };
}
