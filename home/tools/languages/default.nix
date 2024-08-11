{ lib, config, ... }:
{
  imports = [
    ./c
    ./clojure
    ./elixir
    ./go
    ./java
    ./javascript
    ./lua
    ./ocaml
    ./python
    ./rust
    ./sql
    ./zig
  ];
  options = {
    languages.enable = lib.mkEnableOption "Enable programming languages module";
  };
  config = lib.mkIf config.languages.enable {
    c.enable = lib.mkDefault true;
    clojure.enable = lib.mkDefault false;
    elixir.enable = lib.mkDefault false;
    go.enable = lib.mkDefault true;
    java.enable = lib.mkDefault false;
    javascript.enable = lib.mkDefault true;
    lua.enable = lib.mkDefault true;
    ocaml.enable = lib.mkDefault false;
    python.enable = lib.mkDefault true;
    rust.enable = lib.mkDefault true;
    sql.enable = lib.mkDefault true;
    zig.enable = lib.mkDefault true;
  };
}
