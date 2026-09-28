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
  options = {
    serpantinum.enable = lib.mkEnableOption "Enable Serpantinum Shell module";
  };
  config = lib.mkIf config.serpantinum.enable {
    programs.serpantinum = {
      enable = true;
      systemd.enable = true;

      settings = {
        wallpaperDir = "/home/redyf/wallpapers";

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
