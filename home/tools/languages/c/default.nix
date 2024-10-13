{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    c.enable = lib.mkEnableOption "Enable C module";
  };
  config = lib.mkIf config.c.enable {
    home.packages = with pkgs; [
      gcc
    ];
  };
}
