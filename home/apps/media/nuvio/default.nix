{
  pkgs,
  lib,
  config,
  ...
}:
let
  nuvio-engine = pkgs.callPackage ../../../../pkgs/nuvio/engine.nix { };
  nuvio-desktop = pkgs.callPackage ../../../../pkgs/nuvio/desktop.nix { inherit nuvio-engine; };
in
{
  options = {
    nuvio.enable = lib.mkEnableOption "Enable nuvio module";
  };
  config = lib.mkIf config.nuvio.enable {
    home.packages = [ nuvio-desktop ];
  };
}
