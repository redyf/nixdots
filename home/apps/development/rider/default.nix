{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    rider.enable = lib.mkEnableOption "Enable rider module";
  };
  config = lib.mkIf config.rider.enable {
    home.packages = with pkgs; [
      jetbrains.rider
    ];
  };
}
