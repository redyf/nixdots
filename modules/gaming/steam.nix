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
            "-w 1280"
            "-h 960"
            "-W 1920"
            "-H 1080"
            "-r 180"
            "-S stretch"
            "--adaptive-sync"
            "--immediate-flips"
          ];
        };
      };
      gamemode.enable = true;
    };
    environment.systemPackages = with pkgs; [
      mangohud
    ];
    services.archisteamfarm = {
      enable = false;
    };
  };
}
