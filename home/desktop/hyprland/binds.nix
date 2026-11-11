{
  config,
  lib,
  ...
}:
let
  inherit (lib.generators) mkLuaInline;

  # Binds with SUPER, the Lua variable `mod` set in default.nix.
  m = keys: dsp: {
    _args = [
      (mkLuaInline "mod .. \" + ${keys}\"")
      (mkLuaInline dsp)
    ];
  };

in
{
  config = lib.mkIf config.myHomeConfig.desktop.hyprland.enable {
    wayland.windowManager.hyprland = {
      settings = {
        bind = [
          (m "Q" "hl.dsp.window.close()")
          (m "SHIFT + M" "hl.dsp.exit()")
          (m "S" "hl.dsp.window.float()")
          (m "G" "hl.dsp.group.toggle()")

          (m "H" "hl.dsp.focus({ direction = \"left\" })")
          (m "L" "hl.dsp.focus({ direction = \"right\" })")
          (m "K" "hl.dsp.focus({ direction = \"up\" })")
          (m "J" "hl.dsp.focus({ direction = \"down\" })")
          (m "left" "hl.dsp.focus({ direction = \"left\" })")
          (m "down" "hl.dsp.focus({ direction = \"down\" })")
          (m "up" "hl.dsp.focus({ direction = \"up\" })")
          (m "right" "hl.dsp.focus({ direction = \"right\" })")

          (m "1" "hl.dsp.focus({ workspace = \"1\" })")
          (m "2" "hl.dsp.focus({ workspace = \"2\" })")
          (m "3" "hl.dsp.focus({ workspace = \"3\" })")
          (m "4" "hl.dsp.focus({ workspace = \"4\" })")
          (m "5" "hl.dsp.focus({ workspace = \"5\" })")
          (m "6" "hl.dsp.focus({ workspace = \"6\" })")
          (m "7" "hl.dsp.focus({ workspace = \"7\" })")
          (m "8" "hl.dsp.focus({ workspace = \"8\" })")

          (m "SHIFT + 1" "hl.dsp.window.move({ workspace = \"1\", follow = false })")
          (m "SHIFT + 2" "hl.dsp.window.move({ workspace = \"2\", follow = false })")
          (m "SHIFT + 3" "hl.dsp.window.move({ workspace = \"3\", follow = false })")
          (m "SHIFT + 4" "hl.dsp.window.move({ workspace = \"4\", follow = false })")
          (m "SHIFT + 5" "hl.dsp.window.move({ workspace = \"5\", follow = false })")
          (m "SHIFT + 6" "hl.dsp.window.move({ workspace = \"6\", follow = false })")
          (m "SHIFT + 7" "hl.dsp.window.move({ workspace = \"7\", follow = false })")
          (m "SHIFT + 8" "hl.dsp.window.move({ workspace = \"8\", follow = false })")

          (m "SHIFT + K" "hl.dsp.window.move({ direction = \"up\" })")
          (m "SHIFT + J" "hl.dsp.window.move({ direction = \"down\" })")
          (m "SHIFT + left" "hl.dsp.window.move({ direction = \"left\" })")
          (m "SHIFT + right" "hl.dsp.window.move({ direction = \"right\" })")

          (m "period" "hl.dsp.layout(\"move +col\")")
          (m "comma" "hl.dsp.layout(\"move -col\")")
          (m "equal" "hl.dsp.layout(\"colresize +0.2\")")
          (m "minus" "hl.dsp.layout(\"colresize -0.2\")")
          (m "P" "hl.dsp.layout(\"promote\")")
          (m "SHIFT + period" "hl.dsp.window.move({ direction = \"r\" })")
          (m "SHIFT + comma" "hl.dsp.window.move({ direction = \"l\" })")
          (m "SHIFT + H" "hl.dsp.window.move({ direction = \"l\" })")
          (m "SHIFT + L" "hl.dsp.window.move({ direction = \"r\" })")
          (m "M" "hl.dsp.layout(\"togglefit\")")

          (m "RETURN" "hl.dsp.exec_cmd(\"wezterm\")")
          (m "E" "hl.dsp.exec_cmd(\"emacsclient -c -a 'emacs'\")")
          (m "SHIFT + S" "hl.dsp.exec_cmd(\"screenshot\")")
          (m "SHIFT + E" "hl.dsp.exec_cmd(\"screenshot-edit\")")
          (m "O" "hl.dsp.exec_cmd(\"obsidian\")")
          (m "space" "hl.dsp.exec_cmd(\"serpantinum msg toggle launcher\")")
          (m "SHIFT + c" "hl.dsp.exec_cmd(\"serpantinum msg toggle wallpaper\")")

          (m "mouse:272" "hl.dsp.window.drag()")
          (m "mouse:273" "hl.dsp.window.resize()")
        ];
      };
    };
  };
}
