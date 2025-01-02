{ lib, config, ... }:
{
  imports = [
    ./artix-game-launcher
    ./discord
    ./emacs
    ./figma
    ./firefox
    ./insomnia
    ./misc
    ./obs
    ./obsidian
    ./proton
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
    emacs.enable = lib.mkDefault false;
    figma.enable = lib.mkDefault false;
    firefox.enable = lib.mkDefault true;
    insomnia.enable = lib.mkDefault false;
    misc.enable = lib.mkDefault true;
    obs.enable = lib.mkDefault true;
    obsidian.enable = lib.mkDefault true;
    proton.enable = lib.mkDefault false;
    raspberry.enable = lib.mkDefault true;
    vscode.enable = lib.mkDefault false;
    zen.enable = lib.mkDefault true;
  };
}
