{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    chrome.enable = lib.mkEnableOption "Enable chrome module";
  };
  config = lib.mkIf config.rust.enable {
    home.packages = with pkgs; [
      google-chrome
    ];
  };
}
