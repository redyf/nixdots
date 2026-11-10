{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.apps.file-explorer.enable = lib.mkEnableOption "file-explorer";
  config = lib.mkIf config.myHomeConfig.apps.file-explorer.enable {
    home.packages = with pkgs; [
      thunar
      yazi
    ];
  };
}
