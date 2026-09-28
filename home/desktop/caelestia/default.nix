{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    caelestia.enable = lib.mkEnableOption "Enable caelestia module";
  };
  config = lib.mkIf config.caelestia.enable {
    home.packages = [
      pkgs.caelestia-shell
    ];
  };
}
