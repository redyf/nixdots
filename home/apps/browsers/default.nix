{ lib, config, ... }:
{
  imports = [
    ./chrome
    ./vivaldi
    ./zen
  ];

  options = {
    browsers.enable = lib.mkEnableOption "Enable browsers module";
  };
  config = lib.mkIf config.browsers.enable {
    chrome.enable = lib.mkDefault true;
    vivaldi.enable = lib.mkDefault false;
    zen.enable = lib.mkDefault true;
  };
}
