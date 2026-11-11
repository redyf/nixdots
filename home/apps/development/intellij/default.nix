{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.apps.development.intellij.enable = lib.mkEnableOption "intellij";
  config = lib.mkIf config.myHomeConfig.apps.development.intellij.enable {
    home.packages = with pkgs; [
      jetbrains.idea
    ];
  };
}
