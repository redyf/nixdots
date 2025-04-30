{ lib, config, ... }:
{
  imports = [
    ./artix-game-launcher
    ./discord
    ./misc
    ./obs
    ./obsidian
    ./vscode
    ./zen
  ];

  options = {
    apps.enable = lib.mkEnableOption "Enable apps module";
  };
  config = lib.mkIf config.apps.enable {
    artix-game-launcher.enable = lib.mkDefault true;
    discord.enable = lib.mkDefault true;
    misc.enable = lib.mkDefault true;
    obs.enable = lib.mkDefault true;
    obsidian.enable = lib.mkDefault true;
    vscode.enable = lib.mkDefault true;
    zen.enable = lib.mkDefault true;
  };
}
