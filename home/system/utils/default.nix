{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.myHomeConfig.system.utils.enable = lib.mkEnableOption "system utils";
  config = lib.mkIf config.myHomeConfig.system.utils.enable {
    home = {
      packages = with pkgs; [
        jless
        parted
        unzip
        polkit_gnome
        wget
        age
        sops
        btop
      ];
    };
  };
}
