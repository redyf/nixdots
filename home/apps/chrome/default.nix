{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    chrome.enable = lib.mkEnableOption "Enable chrome module";
  };
  config = lib.mkIf config.chrome.enable {
    home.packages = with pkgs; [
      google-chrome
    ];
  };
}
