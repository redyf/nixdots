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
      theme = "catppuccin-macchiato";
      settings = {
        main = {
          font = "TX-02:size=12";
        };
      };
    };
  };
}
