{
  lib,
  config,
  ...
}:
{
  options = {
    firefox.enable = lib.mkEnableOption "Enable firefox module";
  };
  config = lib.mkIf config.firefox.enable {
    programs.firefox.enable = true;
  };
}
