{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    security.enable = lib.mkEnableOption "Enable security module";
  };
  config = lib.mkIf config.security.enable {
    home.packages = with pkgs; [
      bitwarden-desktop
    ];
  };
}
