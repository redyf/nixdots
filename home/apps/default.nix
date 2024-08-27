{ lib, config, ... }:
{
  imports = [
    ./artix-game-launcher
    ./chrome
    ./davinci-resolve
    ./discord
    ./emacs
    ./figma
    ./firefox
    ./insomnia
    ./misc
    ./obs
    ./proton
    ./raspberry
    ./real-vnc-viewer
    ./spotify
    ./vscode
  ];

  options = {
    apps.enable = lib.mkEnableOption "Enable apps module";
  };
  config = lib.mkIf config.apps.enable {
    artix-game-launcher.enable = lib.mkDefault false;
    chrome.enable = lib.mkDefault false;
    davinci-resolve.enable = lib.mkDefault false;
    discord.enable = lib.mkDefault true;
    emacs.enable = lib.mkDefault false;
    figma.enable = lib.mkDefault false;
    firefox.enable = lib.mkDefault true;
    insomnia.enable = lib.mkDefault false;
    misc.enable = lib.mkDefault true;
    obs.enable = lib.mkDefault false;
    proton.enable = lib.mkDefault false;
    raspberry.enable = lib.mkDefault true;
    real-vnc-viewer.enable = lib.mkDefault true;
    spotify.enable = lib.mkDefault false;
    vscode.enable = lib.mkDefault false;
  };
}
