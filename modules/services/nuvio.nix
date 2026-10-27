{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myConfig.services.nuvio;
  nuvio-engine = pkgs.callPackage ../../pkgs/nuvio/engine.nix { };
  nuvio-desktop = pkgs.callPackage ../../pkgs/nuvio/desktop.nix { inherit nuvio-engine; };
in
{
  config = lib.mkIf (config.myConfig.services.enable && cfg.enable) {
    environment.systemPackages = [ nuvio-desktop ];
  };
}
