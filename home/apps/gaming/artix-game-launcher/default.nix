{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    artix-game-launcher.enable = lib.mkEnableOption "Enable artix-game-launcher module";
  };
  config = lib.mkIf config.artix-game-launcher.enable {
    home.packages = [
      (pkgs.callPackage ../../../../pkgs/artix-experimental-launcher.nix { })
    ];
  };
}
