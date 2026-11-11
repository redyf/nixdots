{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.apps.gaming.godot.enable = lib.mkEnableOption "godot";
  config = lib.mkIf config.myHomeConfig.apps.gaming.godot.enable {
    home = {
      packages = [
        pkgs.godot
      ];
    };
  };
}
