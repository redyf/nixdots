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
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    environment = {
      variables = {
        EDITOR = "nvim";
        XDG_SESSION_TYPE = "wayland";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        # Add java to path
        # JAVA_HOME = "${pkgs.jdk23_headless.home}/lib/openjdk";
      };
      sessionVariables = {
        NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
        DEFAULT_BROWSER = "${inputs.zen-browser.packages."${pkgs.system}".twilight}/bin/zen";
      };
    };
  };
}
