{pkgs, ...}: {
  gtk = {
    enable = true;
    cursorTheme = {
      name = "macOS-BigSur";
      package = pkgs.apple-cursor;
      size = 32; # Affects gtk applications as the name suggests
    };

    # theme = {
    # name = "Catppuccin-Macchiato-Compact-Blue-dark";
    # package = pkgs.catppuccin-gtk.override {
    #   size = "compact";
    #   accents = ["blue"];
    #   variant = "macchiato";
    # };
    #   name = "WhiteSur";
    #   package = pkgs.whitesur-gtk-theme;
    # };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-folders;
      # name = "WhiteSur";
      # package = pkgs.whitesur-icon-theme;
    };
  };
}
