{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.tools.languages.lua.enable = lib.mkEnableOption "lua";
  config = lib.mkIf config.myHomeConfig.cli.tools.languages.lua.enable {
    home.packages = with pkgs; [
      lua # Lua programming language
    ];
  };
}
