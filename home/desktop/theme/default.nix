{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    theme.enable = lib.mkEnableOption "Enable theme module";
  };
  config = lib.mkIf config.theme.enable {
    gtk = {
      enable = true;
      cursorTheme = {
        # name = "macOS-BigSur";
        # package = pkgs.apple-cursor;
        name = "Banana";
        package = pkgs.banana-cursor;
        size = 36;
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-folders;
        # name = "WhiteSur";
        # package = pkgs.whitesur-icon-theme;
      };
    };

    stylix = lib.mkIf (builtins.hasAttr "stylix" config) {
      targets = {
        tmux.enable = false;
        mako.enable = true;
        vesktop.enable = false;
        hyprland.enable = false;
        waybar.enable = false;
        bat.enable = true;
        starship.enable = false;
        qt = {
          enable = true;
          platform = "qtct";
        };
      };
    };
  };
}
