{ lib, config, ... }:
{
  imports = [
    ./c
    ./csharp
    ./go
    ./java
    ./javascript
    ./lua
    ./python
    ./rust
  ];
  options = {
    languages.enable = lib.mkEnableOption "Enable programming languages module";
  };
  config = lib.mkIf config.languages.enable {
    c.enable = lib.mkDefault true;
    csharp.enable = lib.mkDefault false;
    go.enable = lib.mkDefault true;
    java.enable = lib.mkDefault false;
    javascript.enable = lib.mkDefault true;
    lua.enable = lib.mkDefault true;
    python.enable = lib.mkDefault true;
    rust.enable = lib.mkDefault true;
  };
}
