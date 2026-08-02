{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    cymbal.enable = lib.mkEnableOption "Enable cymbal module";
  };
  config = lib.mkIf config.cymbal.enable {
    home.packages = with pkgs; [
      (callPackage ../../../../pkgs/cymbal.nix { })
    ];
  };
}
