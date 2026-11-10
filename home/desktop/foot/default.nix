{
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.desktop.foot.enable = lib.mkEnableOption "foo term";
  config = lib.mkIf config.myHomeConfig.desktop.foot.enable {
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
