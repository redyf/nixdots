{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    fd.enable = lib.mkEnableOption "Enable fd module";
  };
  config = lib.mkIf config.fd.enable {
    home.packages = with pkgs; [fd];
  };
}
