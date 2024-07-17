{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    lua.enable = lib.mkEnableOption "Enable lua module";
  };
  config = lib.mkIf config.lua.enable {
    home.packages = with pkgs; [
      lua # Lua programming language
      stylua # Lua formatter
      selene # Lua linter written in rust
      lua-language-server # Lua LSP
    ];
  };
}
