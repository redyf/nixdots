{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    hytale.enable = lib.mkEnableOption "Enable hytale module";
  };
  config = lib.mkIf config.hytale.enable {
    home = {
      packages = with pkgs; [
        (callPackage ../../../../pkgs/hytale.nix { })
      ];
    };
  };
}
