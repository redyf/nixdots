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
        name = "macOS-BigSur";
        package = pkgs.apple-cursor;
        size = 36;
      };

      iconTheme = {
        name = "WhiteSur";
        package = pkgs.whitesur-icon-theme;
      };
      theme = {
        name = lib.mkDefault "WhiteSur";
        package = lib.mkDefault pkgs.whitesur-gtk-theme;
      };
    };

    stylix = lib.mkIf (builtins.hasAttr "stylix" config) {
      targets = {
        bat.enable = true;
        cava = {
          enable = true;
          rainbow.enable = true;
        };
        ghostty.enable = true;
        hyprland.enable = true;
        mako.enable = true;
        qt = {
          enable = true;
          platform = "qtct";
        };
        starship.enable = true;
        tmux.enable = false;
        vesktop.enable = false;
        waybar.enable = false;
        wezterm.enable = true;
      };
    };
  };
}
