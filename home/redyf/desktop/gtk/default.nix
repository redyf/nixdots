{pkgs, ...}: {
  gtk = {
    enable = true;
    cursorTheme = {
      name = "macOS-BigSur";
      package = pkgs.apple-cursor;
      size = 32; # Affects gtk applications as the name suggests
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
}
