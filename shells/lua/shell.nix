{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    lua # Lua programming language
    stylua # Lua formatter
    selene # Lua linter written in rust
    lua-language-server # Lua LSP
    luajitPackages.luarocks-nix # Package manager for Lua on Nix
  ];
  shellHook = ''
    echo "Environment is ready" | ${pkgs.lolcat}/bin/lolcat;
  '';
}
