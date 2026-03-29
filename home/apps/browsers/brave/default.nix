{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    brave.enable = lib.mkEnableOption "Enable brave browser";
  };
  config = lib.mkIf config.brave.enable {
    home.packages = [
      pkgs.brave
    ];
  };
}
