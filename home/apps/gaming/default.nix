{ lib, config, ... }:
{
  imports = [
    ./artix-game-launcher
    ./godot
    ./minecraft
    ./unity
  ];

  options = {
    gaming.enable = lib.mkEnableOption "Enable gaming module";
  };
  config = lib.mkIf config.gaming.enable {
    artix-game-launcher.enable = lib.mkDefault true;
    godot.enable = lib.mkDefault false;
    minecraft.enable = lib.mkDefault false;
    unity.enable = lib.mkDefault true;
  };
}
