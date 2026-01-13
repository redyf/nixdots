{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    file-explorer.enable = lib.mkEnableOption "Enable file-explorer module";
  };
  config = lib.mkIf config.file-explorer.enable {
    home.packages = with pkgs; [
      thunar
      yazi
    ];
  };
}
