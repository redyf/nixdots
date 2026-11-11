{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.apps.gaming.artix-game-launcher.enable =
    lib.mkEnableOption "artix-game-launcher";
  config = lib.mkIf config.myHomeConfig.apps.gaming.artix-game-launcher.enable {
    home.packages = [ pkgs.artix-experimental-launcher ];
  };
}
