{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.apps.browsers.zen.enable = lib.mkEnableOption "zen";
  config = lib.mkIf config.myHomeConfig.apps.browsers.zen.enable {
    home.packages = [
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
