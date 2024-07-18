{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    sql.enable = lib.mkEnableOption "Enable sql module";
  };
  config = lib.mkIf config.sql.enable {
    home.packages = with pkgs; [
      postgresql
      # beekeeper-studio
      # mysql-workbench
    ];
  };
}
