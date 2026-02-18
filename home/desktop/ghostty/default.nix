{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  ghostty-wrapped-overlay = self: super: {
    ghostty = super.ghostty.overrideAttrs (old: {
      buildInputs = old.buildInputs ++ [ pkgs.makeWrapper ];
      postInstall = old.postInstall or "" + ''
        wrapProgram "$out/bin/ghostty" \
        --set GDK_BACKEND x11 \
      '';
    });
  };
in
{
  options = {
    ghostty.enable = lib.mkEnableOption "Enable ghostty module";
  };
  config = lib.mkIf config.ghostty.enable {
    # nixpkgs.overlays = [ ghostty-wrapped-overlay ];
    programs.ghostty = {
      enable = true;
      package = pkgs.ghostty;
      settings = {
        font-family = "JetBrainsMono Nerd Font";
        font-size = 13;
        font-style = "Medium";
        font-style-bold = "Bold";
        font-style-italic = "Italic";
        font-style-bold-italic = "Bold Italic";
        font-thicken = true;
        bold-is-bright = false;

        adjust-cell-height = "-2%";
        adjust-cursor-thickness = 15;

        cursor-style = "bar";
        cursor-style-blink = false;
        cursor-click-to-move = false;

        mouse-hide-while-typing = false;
        mouse-scroll-multiplier = 1;

        background-blur = 0;
        background-opacity = 0.8;
        fullscreen = false;

        window-padding-x = 5;
        window-padding-y = 5;

        confirm-close-surface = false;

        # shell-integration = "zsh";
        shell-integration-features = "no-cursor,no-sudo,title";

        gtk-single-instance = "desktop";
        gtk-titlebar = false;
        gtk-tabs-location = "top";
        gtk-wide-tabs = true;

        theme = "Catppuccin Macchiato";

        keybind = [
          "ctrl+minus=unbind"
          "ctrl+-=unbind"
          "ctrl+equal=unbind"
          "ctrl+plus=unbind"

          "ctrl+shift+plus=increase_font_size:1"
          "ctrl+shift+equal=increase_font_size:1"
          "ctrl+shift+minus=decrease_font_size:1"
        ];

        # custom-shader = "shaders/aurora.glsl";
        custom-shader = "shaders/cursor_smear.glsl";
        # custom-shader = "shaders/cursor_blaze.glsl";
        # custom-shader = "shaders/cursor_blaze_no_trail.glsl";
        # custom-shader = "shaders/cursor_frozen.glsl";
        # custom-shader = "shaders/manga_slash.glsl";
        # custom-shader = "shaders/galaxy.glsl";
        # custom-shader = "shaders/starfield.glsl";
        # custom-shader = "shaders/retro-terminal.glsl";
        # custom-shader = "shaders/gears-and-belts.glsl";
        # custom-shader = "shaders/in-game-crt.glsl";
        # custom-shader = "shaders/just-snow.glsl";
        # custom-shader = "shaders/fireworks.glsl";
        # custom-shader = "shaders/fireworks-rockets.glsl";
        # custom-shader = "shaders/sparks-from-fire.glsl";
        # custom-shader = "shaders/spotlight.glsl";
        # custom-shader = "cursor_shaders/cursor_warp.glsl";
        # custom-shader = "cursor_shaders/cursor_sweep.glsl";
        # custom-shader = "cursor_shaders/cursor_tail.glsl";
        # custom-shader = "cursor_shaders/ripple_cursor.glsl";
        # custom-shader = "cursor_shaders/sonic_boom.glsl";
        # custom-shader = "cursor_shaders/ripple_rectangle.glsl";
        # custom-shader = "cursor_shaders/ripple_rectangle_boom.glsl";
      };
    };
  };
}
