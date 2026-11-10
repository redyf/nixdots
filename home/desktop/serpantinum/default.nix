{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [
    inputs.serpantinum.homeManagerModules.default
  ];
  options.myHomeConfig.desktop.serpantinum.enable = lib.mkEnableOption "Serpantinum Shell";
  config = lib.mkIf config.myHomeConfig.desktop.serpantinum.enable {
    programs.serpantinum = {
      enable = true;
      systemd.enable = true;

      settings = {
        wallpaperDir = "${config.home.homeDirectory}/wallpapers";

        general = {
          language = "en";
          weatherUnit = "metric";
          weatherInterval = 30;
        };

        bar = {
          position = "bottom";
          style = "solid";
          width = 100;
          workspaceCount = 6;
          modules = {
            center = [ "workspaces" ];
            left = [ "time" ];
            right = [
              "tray"
              [
                "kb"
                "wifi"
                "bt"
                "vol"
                "bat"
              ]
            ];
          };
        };

        theme = {
          fontFamily = "TX-02";
          borderRadius = 12;
          matugen = true;
        };

        notifications = {
          dnd = true;
          position = "top right";
          sound = true;
        };
      };
    };
  };
}
