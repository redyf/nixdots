{
  lib,
  config,
  ...
}:
{
  options = {
    ripgrep.enable = lib.mkEnableOption "Enable ripgrep module";
  };
  config = lib.mkIf config.ripgrep.enable {
    programs.ripgrep = {
      enable = true;
    };
  };
}
