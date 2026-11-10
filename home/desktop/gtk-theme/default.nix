{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHomeConfig.desktop.gtk-theme.enable = lib.mkEnableOption "gtk";
  config = lib.mkIf config.myHomeConfig.desktop.gtk-theme.enable {
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
      gtk4.theme = lib.mkDefault config.gtk.theme;
    };
  };
}
