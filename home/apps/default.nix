{ lib, config, ... }:
{
  imports = [
    ./artix-game-launcher
    ./discord
    ./figma
    ./firefox
    ./insomnia
    ./misc
    ./obs
    ./obsidian
    ./raspberry
    ./vscode
    ./zen
  ];

  options = {
    apps.enable = lib.mkEnableOption "Enable apps module";
  };
  config = lib.mkIf config.apps.enable {
    artix-game-launcher.enable = lib.mkDefault true;
    discord.enable = lib.mkDefault true;
    figma.enable = lib.mkDefault false;
    firefox.enable = lib.mkDefault false;
    insomnia.enable = lib.mkDefault false;
    misc.enable = lib.mkDefault true;
    obs.enable = lib.mkDefault true;
    obsidian.enable = lib.mkDefault true;
    raspberry.enable = lib.mkDefault true;
    vscode.enable = lib.mkDefault true;
    zen.enable = lib.mkDefault true;
  };
}
