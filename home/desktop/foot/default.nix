{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    foot.enable = lib.mkEnableOption "Enable foo term module";
  };
  config = lib.mkIf config.foot.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          pad = "12x12";
        };
      };
    };
  };
}
