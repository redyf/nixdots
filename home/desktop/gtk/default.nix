{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    gtk-theme.enable = lib.mkEnableOption "Enable gtk module";
  };
  config = lib.mkIf config.gtk-theme.enable {
    gtk = {
      enable = true;
      iconTheme = {
        name = "WhiteSur";
        package = pkgs.whitesur-icon-theme;
      };
      theme = {
        name = lib.mkDefault "WhiteSur-dark";
        package = lib.mkDefault pkgs.whitesur-gtk-theme;
      };
    };
  };
}
