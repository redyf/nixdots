{
  lib,
  config,
  ...
}: {
  imports = [
    ./c
    ./go
    ./rust
    ./python
    ./javascript
    ./ocaml
    ./sql
    ./java
    ./lua
    ./elixir
    ./clojure
  ];
  options = {
    languages.enable = lib.mkEnableOption "Enable programming languages module";
  };
  config = lib.mkIf config.languages.enable {
    c.enable = lib.mkDefault true;
    go.enable = lib.mkDefault true;
    rust.enable = lib.mkDefault true;
    python.enable = lib.mkDefault true;
    javascript.enable = lib.mkDefault true;
    ocaml.enable = lib.mkDefault false;
    sql.enable = lib.mkDefault true;
    java.enable = lib.mkDefault false;
    lua.enable = lib.mkDefault true;
    elixir.enable = lib.mkDefault false;
    clojure.enable = lib.mkDefault false;
  };
}
