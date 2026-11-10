{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.cli.tools.cymbal.enable = lib.mkEnableOption "cymbal";
  config = lib.mkIf config.myHomeConfig.cli.tools.cymbal.enable {
    home.packages = with pkgs; [
      (callPackage ../../../../pkgs/cymbal.nix { })
    ];
  };
}
