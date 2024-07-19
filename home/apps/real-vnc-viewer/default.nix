{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    real-vnc-viewer.enable = lib.mkEnableOption "Enable real-vnc-viewer module";
  };
  config = lib.mkIf config.real-vnc-viewer.enable {
    home.packages = with pkgs;
      if pkgs.stdenv.isAarch64
      then [
        (pkgs.callPackage ../../../pkgs/real-vnc-viewer.nix {
          src = real-vnc-viewer; # pkg source is passed as a `specialArgs` and injected into this module.
        })
      ]
      else if pkgs.stdenv.isx86_64
      then [
        realvnc-vnc-viewer
      ]
      else [];
  };
}
