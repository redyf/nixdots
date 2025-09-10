{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    ghostty.enable = lib.mkEnableOption "Enable ghostty module";
  };
  config = lib.mkIf config.ghostty.enable {
    programs.ghostty = {
      enable = true;
      package = inputs.ghostty.packages.${pkgs.system}.default;
      settings = {
        font-family = "Cartograph CF";
        font-size = 14;
        font-style = "Medium";
        font-style-bold = "Bold";
        font-style-italic = "Italic";
        font-style-bold-italic = "Bold Italic";
        font-thicken = true;
        bold-is-bright = false;

        adjust-cursor-thickness = 15;

        cursor-style = "block";
        cursor-style-blink = false;
        cursor-click-to-move = false;

        mouse-hide-while-typing = false;
        mouse-scroll-multiplier = 1;

        background-blur = 255;
        background-opacity = 1;
        fullscreen = false;

        window-padding-x = 5;
        window-padding-y = 5;

        confirm-close-surface = false;

        shell-integration = "zsh";
        shell-integration-features = "cursor,no-sudo,title";

        gtk-single-instance = "desktop";
        gtk-titlebar = false;
        gtk-tabs-location = "top";
        gtk-wide-tabs = true;

        theme = "tokyonight_moon";

        # custom-shader = "shaders/aurora.glsl";
        # custom-shader = "shaders/cursor_smear.glsl";
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
      };
    };
  };
}
