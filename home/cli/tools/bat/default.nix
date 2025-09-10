{
  lib,
  config,
  ...
}:
{
  options = {
    bat.enable = lib.mkEnableOption "Enable bat module";
  };
  config = lib.mkIf config.bat.enable {
    programs.bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
    };
  };
}
