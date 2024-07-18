{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    raspberry.enable = lib.mkEnableOption "Enable raspberry module";
  };
  config = lib.mkIf config.raspberry.enable {
    home.packages = with pkgs; [
      rpi-imager
      realvnc-vnc-viewer
    ];
  };
}
