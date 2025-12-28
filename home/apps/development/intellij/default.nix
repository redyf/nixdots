{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    intellij.enable = lib.mkEnableOption "Enable intellij module";
  };
  config = lib.mkIf config.intellij.enable {
    home.packages = with pkgs; [
      jetbrains.idea
    ];
  };
}
