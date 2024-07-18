{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    http.enable = lib.mkEnableOption "Enable http module";
  };
  config = lib.mkIf config.http.enable {
    home.packages = with pkgs; [curl openssl];
  };
}
