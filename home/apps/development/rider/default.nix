{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.apps.development.rider.enable = lib.mkEnableOption "rider";
  config = lib.mkIf config.myHomeConfig.apps.development.rider.enable {
    home.packages = with pkgs; [
      jetbrains.rider
    ];
  };
}
