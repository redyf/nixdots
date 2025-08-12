{ lib, config, ... }:
{
  imports = [
    ./discord
    ./zen
  ];

  options = {
    web.enable = lib.mkEnableOption "Enable web module";
  };
  config = lib.mkIf config.web.enable {
    discord.enable = lib.mkDefault true;
    zen.enable = lib.mkDefault true;
  };
}
