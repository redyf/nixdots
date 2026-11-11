{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.apps.browsers.brave.enable = lib.mkEnableOption "brave browser";
  config = lib.mkIf config.myHomeConfig.apps.browsers.brave.enable {
    home.packages = [
      inputs.brave.packages.${pkgs.stdenv.hostPlatform.system}.brave-origin
    ];
  };
}
