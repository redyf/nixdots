{
  lib,
  pkgs,
  config,
  ...
}:
{
  options = {
    utils.enable = lib.mkEnableOption "Enable system utils module";
  };
  config = lib.mkIf config.utils.enable {
    home = {
      packages = with pkgs; [
        jless
        parted
        unzip
        polkit_gnome
      ];
    };
  };
}
