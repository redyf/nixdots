{ lib, config, ... }:
{
  imports = [
    ./chrome
    ./zen
  ];

  options = {
    browsers.enable = lib.mkEnableOption "Enable browsers module";
  };
  config = lib.mkIf config.browsers.enable {
    chrome.enable = lib.mkDefault true;
    zen.enable = lib.mkDefault true;
  };
}
