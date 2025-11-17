{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    unity.enable = lib.mkEnableOption "Enable Unity module";
  };
  config = lib.mkIf config.unity.enable {
    home = {
      packages = [
        pkgs.unityhub
      ];
    };
  };
}
