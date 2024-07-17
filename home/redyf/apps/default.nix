{
  lib,
  config,
  ...
}: {
  imports = [
    ./artix-game-launcher
    ./chrome
    ./discord
    ./davinci-resolve
    ./emacs
    ./figma
    ./firefox
    ./insomnia
    ./raspberry
    ./spotify
    ./misc
    ./obs
    ./vscode
  ];

  options = {
    apps.enable = lib.mkEnableOption "Enable apps module";
  };
  config = lib.mkIf config.apps.enable {
    artix-game-launcher.enable = lib.mkDefault false;
    chrome.enable = lib.mkDefault false;
    discord.enable = lib.mkDefault true;
    davinci-resolve.enable = lib.mkDefault false;
    emacs.enable = lib.mkDefault false;
    figma.enable = lib.mkDefault true;
    firefox.enable = lib.mkDefault true;
    insomnia.enable = lib.mkDefault false;
    raspberry.enable = lib.mkDefault true;
    spotify.enable = lib.mkDefault true;
    misc.enable = lib.mkDefault true;
    obs.enable = lib.mkDefault true;
    vscode.enable = lib.mkDefault false;
  };
}
