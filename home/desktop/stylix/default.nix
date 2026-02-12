{
  pkgs,
  lib,
  config,
  ...
}:
let
  themes = {
    catppuccin-mocha = "catppuccin-mocha";
    oxocarbon-dark = "oxocarbon-dark";
    tokyo-night-moon = "tokyo-night-moon";
    tokyo-night-dark = "tokyo-night-dark";
    tokyo-night-storm = "tokyo-night-storm";
  };
in
{
  options = {
    stylix-theme.enable = lib.mkEnableOption "Enable stylix home module";
  };
  config = lib.mkIf config.stylix-theme.enable {
    stylix = {
      enable = true;
      polarity = "dark";
      cursor = {
        name = "macOS";
        package = pkgs.apple-cursor;
        size = 36;
      };
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${themes.catppuccin-mocha}.yaml";
      targets = {
        bat.enable = true;
        blender.enable = false;
        cava = {
          enable = true;
          rainbow.enable = true;
        };
        firefox.enable = true;
        fzf.enable = true;
        foot.enable = true;
        ghostty.enable = false;
        gtk.enable = true;
        gnome.enable = false;
        hyprland.enable = false;
        mako.enable = true;
        nixos-icons.enable = true;
        qt.enable = true;
        rofi.enable = true;
        starship.enable = false;
        sway.enable = true;
        tmux.enable = false;
        vesktop.enable = false;
        waybar.enable = false;
        wezterm.enable = false;
        noctalia-shell.enable = false;
      };
    };
  };
}
