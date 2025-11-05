{ lib, config, ... }:
{
  imports = [
    ./artix-game-launcher
    ./minecraft
  ];

  options = {
    gaming.enable = lib.mkEnableOption "Enable gaming module";
  };
  config = lib.mkIf config.gaming.enable {
    artix-game-launcher.enable = lib.mkDefault true;
    minecraft.enable = lib.mkDefault false;
  };
}
