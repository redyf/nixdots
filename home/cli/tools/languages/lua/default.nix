{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    lua.enable = lib.mkEnableOption "Enable lua module";
  };
  config = lib.mkIf config.lua.enable {
    home.packages = with pkgs; [
      lua # Lua programming language
    ];
  };
}
