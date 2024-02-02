{ options
, config
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop;
in
{
  options.desktop = with types; {
    colorscheme = mkOpt str "catppuccin-mocha" "Theme to use for the desktop";
    autoLogin = mkBoolOpt false "Enable autologin";
  };

  config = {
    environment.variables = {
      GTK_THEME = "Catppuccin-Mocha-Compact-Blue-dark";
    };

    home.extraOptions.gtk = {
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
          accents = [ "blue" ];
          variant = "macchiato";
        };
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-folders;
      };
    };

    services.xserver.displayManager.autoLogin = mkIf cfg.autoLogin {
      enable = true;
      user = config.user.name;
    };
  };
}
