{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.apps.development.database.enable = lib.mkEnableOption "database";
  config = lib.mkIf config.myHomeConfig.apps.development.database.enable {
    home.packages = with pkgs; [
      dbeaver-bin
    ];
  };
}
