{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    vivaldi.enable = lib.mkEnableOption "Enable vivaldi module";
  };
  config = lib.mkIf config.vivaldi.enable {
    home.packages = [
      pkgs.vivaldi
    ];
  };
}
