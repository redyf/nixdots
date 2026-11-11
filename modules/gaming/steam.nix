{
  config,
  lib,
  username,
  ...
}:

let
  cfg = config.myConfig.gaming.steam;
in
{
  options.myConfig.gaming.steam.enable = lib.mkEnableOption "Steam gaming platform";

  config = lib.mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
      };
      gamemode.enable = true;
    };

    users.users.${username}.extraGroups = [ "gamemode" ];
  };
}
