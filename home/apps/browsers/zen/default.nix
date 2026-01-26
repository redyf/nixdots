{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    zen.enable = lib.mkEnableOption "Enable zen module";
  };
  config = lib.mkIf config.zen.enable {
    home.packages = [
      inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".twilight
    ];
  };
}
