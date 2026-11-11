{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:

let
  cfg = config.myConfig.system.environment;
in
{
  options.myConfig.system.environment = {
    enable = lib.mkEnableOption "environment";
    defaultBrowser = {
      package = lib.mkOption {
        type = lib.types.package;
        default = inputs.brave.packages.${pkgs.stdenv.hostPlatform.system}.brave-origin;
        description = "Browser exported as DEFAULT_BROWSER.";
      };
      desktopFile = lib.mkOption {
        type = lib.types.str;
        default = "brave-origin.desktop";
        description = "Desktop entry of defaultBrowser, used as the MIME handler for web links.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment = {
      variables = {
        EDITOR = "nvim";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      };
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
        DEFAULT_BROWSER = lib.getExe cfg.defaultBrowser.package;
      };
    };
  };
}
