{
  inputs,
  pkgs,
  lib,
  config,
  theme,
  ...
}:
{
  options.myHomeConfig.desktop.stylix-theme.enable = lib.mkEnableOption "stylix home";
  config = lib.mkIf config.myHomeConfig.desktop.stylix-theme.enable {
    stylix = {
      enable = true;
      inherit (theme) polarity;
      cursor = {
        inherit (theme.cursor) name size;
        package = pkgs.apple-cursor;
      };
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme.scheme}.yaml";
      fonts = {
        monospace = {
          package = inputs.font-flake.packages.${pkgs.stdenv.hostPlatform.system}.${theme.monospace.package};
          inherit (theme.monospace) name;
        };
        sizes.terminal = theme.terminalFontSize;
      };
      targets = {
        bat.enable = true;
        blender.enable = false;
        cava = {
          enable = true;
          rainbow.enable = true;
        };
        firefox.enable = false;
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
        starship.enable = true;
        sway.enable = true;
        tmux.enable = false;
        vesktop.enable = false;
        wezterm.enable = true;
        noctalia-shell.enable = false;
        zen-browser.enable = true;
      };
    };
  };
}
