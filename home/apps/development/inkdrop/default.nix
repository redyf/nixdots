{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    inkdrop.enable = lib.mkEnableOption "Enable inkdrop module";
  };
  config = lib.mkIf config.inkdrop.enable {
    home.packages = [
      (pkgs.callPackage ../../../../pkgs/inkdrop.nix { })
    ];
  };
}
