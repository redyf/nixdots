{
  config,
  lib,
  keyboard,
  ...
}:

let
  cfg = config.myConfig.system.keymap;
in
{
  # Keyboard layout comes from `keyboard` in hosts/<name>/meta.nix. The xkb
  # options are set even without X11 so the console can reuse them.
  config = lib.mkIf (config.myConfig.system.enable && cfg.enable) {
    services.xserver.xkb = {
      inherit (keyboard) layout variant;
    };
    console.useXkbConfig = true;
    # Default for Wayland compositors with no layout of their own (Sway
    # without a Home Manager config); Hyprland sets kb_layout explicitly.
    environment.sessionVariables = {
      XKB_DEFAULT_LAYOUT = keyboard.layout;
      XKB_DEFAULT_VARIANT = keyboard.variant;
    };
  };
}
