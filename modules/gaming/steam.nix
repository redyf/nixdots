{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myConfig.gaming.steam;
in
{
  config = lib.mkIf (config.myConfig.gaming.enable && cfg.enable) {
    programs = {
      steam = {
        enable = true;
        gamescopeSession = {
          enable = true;
          args = [
            "-w 1920"
            "-h 1080"
            "-r 180"
            "--adaptive-sync"
            "--immediate-flips"
          ];
        };
      };
      gamemode.enable = true;
    };
    services.archisteamfarm = {
      enable = true;
    };
  };
}
