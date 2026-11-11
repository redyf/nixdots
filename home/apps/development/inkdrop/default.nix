{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.apps.development.inkdrop.enable = lib.mkEnableOption "inkdrop";
  config = lib.mkIf config.myHomeConfig.apps.development.inkdrop.enable {
    home.packages = [ pkgs.inkdrop ];
  };
}
