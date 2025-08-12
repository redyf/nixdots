{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    minecraft.enable = lib.mkEnableOption "Enable minecraft module";
  };
  config = lib.mkIf config.minecraft.enable {
    home.packages = [
      pkgs.prismlauncher
    ];
  };
}
