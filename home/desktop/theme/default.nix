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
        size = 36; # Affects gtk applications as the name suggests
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-folders;
        # name = "WhiteSur";
        # package = pkgs.whitesur-icon-theme;
      };
    };

    stylix = {
      targets = {
        bemenu = {
          enable = true;
          alternate = true;
          fontSize = 14;
        };
        tmux.enable = false;
        mako.enable = true;
        vesktop.enable = true;
      };
    };
  };
}
