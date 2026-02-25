{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    web.enable = lib.mkEnableOption "Enable web module";
  };
  config = lib.mkIf config.web.enable {
    home.packages = with pkgs; [
      vesktop
      slack
      # (pkgs.writeShellScriptBin "slack-x11" ''
      #   exec env ELECTRON_OZONE_PLATFORM_HINT=x11 ${pkgs.slack}/bin/slack "$@"
      # '')
      # slack-x11
    ];
  };
}
