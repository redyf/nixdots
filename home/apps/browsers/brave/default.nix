{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    brave.enable = lib.mkEnableOption "Enable brave browser";
  };
  config = lib.mkIf config.brave.enable {
    home.packages = [
      inputs.brave.packages.${pkgs.stdenv.hostPlatform.system}.brave-origin
    ];
  };
}
