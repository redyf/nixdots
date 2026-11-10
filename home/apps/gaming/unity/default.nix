{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.apps.gaming.unity.enable = lib.mkEnableOption "Unity";
  config = lib.mkIf config.myHomeConfig.apps.gaming.unity.enable {
    home = {
      packages = [
        pkgs.unityhub
      ];
    };
  };
}
