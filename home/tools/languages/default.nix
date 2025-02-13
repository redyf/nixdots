{ lib, config, ... }:
{
  imports = [
    ./c
    ./csharp
    ./elixir
    ./go
    ./java
    ./javascript
    ./lua
    ./python
    ./rust
    ./zig
  ];
  options = {
    languages.enable = lib.mkEnableOption "Enable programming languages module";
  };
  config = lib.mkIf config.languages.enable {
    c.enable = lib.mkDefault true;
    csharp.enable = lib.mkDefault true;
    elixir.enable = lib.mkDefault false;
    go.enable = lib.mkDefault true;
    java.enable = lib.mkDefault true;
    javascript.enable = lib.mkDefault true;
    lua.enable = lib.mkDefault true;
    python.enable = lib.mkDefault true;
    rust.enable = lib.mkDefault true;
    zig.enable = lib.mkDefault true;
  };
}
