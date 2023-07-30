{
  config,
  pkgs,
  lib,
  ...
}: {
  gtk = {
    enable = true;
    cursorTheme = {
      name = "macOS-BigSur";
      package = pkgs.apple-cursor;
      size = 32; # Affects gtk applications as the name suggests
    };

    theme = {
      name = "Catppuccin-Macchiato-Compact-Blue-dark";
      package = pkgs.catppuccin-gtk.override {
        size = "compact";
        accents = ["blue"];
        # tweaks = ["rimless" "black"]; # You can also specify multiple tweaks here
        variant = "macchiato";
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-folders;
    };

    # iconTheme = {
    #   name = "Papirus-Dark";
    #   package = pkgs.papirus-icon-theme;
    # };

    # theme = {
    #   name = "whitesur-gtk-theme";
    #   package = pkgs.whitesur-gtk-theme;
    # };

    # iconTheme = {
    #   name = "WhiteSur";
    #   package = pkgs.whitesur-icon-theme;
    # };
  };
}
