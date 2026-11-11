{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  base = inputs.serpantinum.packages.${pkgs.stdenv.hostPlatform.system}.default;
  # Upstream serpantinum-core links -lsqlite3 but does not declare sqlite.
  core = base.serpantinum-core.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.pkg-config ];
    buildInputs = (old.buildInputs or [ ]) ++ [ pkgs.sqlite ];
  });
in
{
  imports = [
    inputs.serpantinum.homeManagerModules.default
  ];
  options.myHomeConfig.desktop.serpantinum.enable = lib.mkEnableOption "Serpantinum Shell";
  config = lib.mkIf config.myHomeConfig.desktop.serpantinum.enable {
    programs.serpantinum = {
      enable = true;
      package = base.override { serpantinum-core = core; };
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
          fontFamily = config.stylix.fonts.monospace.name;
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
