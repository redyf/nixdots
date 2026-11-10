{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.apps.security.enable = lib.mkEnableOption "security";
  config = lib.mkIf config.myHomeConfig.apps.security.enable {
    home.packages = with pkgs; [
      bitwarden-desktop
    ];
  };
}
