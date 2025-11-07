{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    godot.enable = lib.mkEnableOption "Enable godot module";
  };
  config = lib.mkIf config.godot.enable {
    home = {
      packages = [
        pkgs.godot
      ];
    };
  };
}
