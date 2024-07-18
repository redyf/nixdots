{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    ocaml.enable = lib.mkEnableOption "Enable ocaml module";
  };
  config = lib.mkIf config.ocaml.enable {
    home.packages = with pkgs; [
      ocaml
      opam
    ];
  };
}
