{pkgs, ...}: {
  home.packages = with pkgs; [
    # Lua packages
    lua # Lua programming language
    stylua # Lua formatter
    selene # Lua linter written in rust
    # luaformatter # Lua formatter (currently using this one)
    lua-language-server # Lua LSP
    luajitPackages.luarocks-nix # Package manager for Lua on Nix
  ];
}
