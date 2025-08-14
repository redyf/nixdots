{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    database.enable = lib.mkEnableOption "Enable database module";
  };
  config = lib.mkIf config.database.enable {
    home.packages = with pkgs; [
      beekeeper-studio
    ];
  };
}
