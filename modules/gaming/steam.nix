{
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
        gamescopeSession.enable = true;
      };
      gamemode.enable = true;
    };
    services.archisteamfarm = {
      enable = false;
    };
  };
}
