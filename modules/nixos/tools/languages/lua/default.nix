{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.tools.languages.lua;
in {
  options.tools.languages.lua = with types; {
    enable = mkBoolOpt false "Enable lua";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lua # Lua programming language
      stylua # Lua formatter
      selene # Lua linter written in rust
      lua-language-server # Lua LSP
      luajitPackages.luarocks-nix # Package manager for Lua on Nix
    ];
  };
}
