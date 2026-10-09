{ lib, config, ... }:
{
  imports = [
    ./brave
    ./chrome
    ./firefox
    ./vivaldi
    ./zen
  ];

  options = {
    browsers.enable = lib.mkEnableOption "Enable browsers module";
  };
  config = lib.mkIf config.browsers.enable {
    brave.enable = lib.mkDefault true;
    chrome.enable = lib.mkDefault false;
    firefox.enable = lib.mkDefault false;
    vivaldi.enable = lib.mkDefault false;
    zen.enable = lib.mkDefault false;
  };
}
