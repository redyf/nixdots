{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.desktop.caelestia.enable = lib.mkEnableOption "caelestia";
  config = lib.mkIf config.myHomeConfig.desktop.caelestia.enable {
    home.packages = [
      pkgs.caelestia-shell
    ];
  };
}
