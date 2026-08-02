{
  lib,
  ...
}:
let
  inherit (lib.generators) mkLuaInline;

  # bind com SUPER (variável Lua `mod`, definida em default.nix)
  m = keys: dsp: {
    _args = [
      (mkLuaInline "mod .. \" + ${keys}\"")
      (mkLuaInline dsp)
    ];
  };

  # bind com teclas fixas
  k = keys: dsp: {
    _args = [
      keys
      (mkLuaInline dsp)
    ];
  };
in
{
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        # killactive / exit / togglefloating / togglegroup
        (m "Q" "hl.dsp.window.close()")
        (m "SHIFT + M" "hl.dsp.exit()")
        (m "S" "hl.dsp.window.float()")
        (m "G" "hl.dsp.group.toggle()")

        # movefocus
        (m "H" "hl.dsp.focus({ direction = \"left\" })")
        (m "L" "hl.dsp.focus({ direction = \"right\" })")
        (m "K" "hl.dsp.focus({ direction = \"up\" })")
        (m "J" "hl.dsp.focus({ direction = \"down\" })")
        (m "left" "hl.dsp.focus({ direction = \"left\" })")
        (m "down" "hl.dsp.focus({ direction = \"right\" })")
        (m "up" "hl.dsp.focus({ direction = \"up\" })")
        (m "right" "hl.dsp.focus({ direction = \"down\" })")

        # workspace
        (m "1" "hl.dsp.focus({ workspace = \"1\" })")
        (m "2" "hl.dsp.focus({ workspace = \"2\" })")
        (m "3" "hl.dsp.focus({ workspace = \"3\" })")
        (m "4" "hl.dsp.focus({ workspace = \"4\" })")
        (m "5" "hl.dsp.focus({ workspace = \"5\" })")
        (m "6" "hl.dsp.focus({ workspace = \"6\" })")
        (m "7" "hl.dsp.focus({ workspace = \"7\" })")
        (m "8" "hl.dsp.focus({ workspace = \"8\" })")

        # movetoworkspacesilent (SUPER duplicado do original corrigido)
        (m "SHIFT + 1" "hl.dsp.window.move({ workspace = \"1\", follow = false })")
        (m "SHIFT + 2" "hl.dsp.window.move({ workspace = \"2\", follow = false })")
        (m "SHIFT + 3" "hl.dsp.window.move({ workspace = \"3\", follow = false })")
        (m "SHIFT + 4" "hl.dsp.window.move({ workspace = \"4\", follow = false })")
        (m "SHIFT + 5" "hl.dsp.window.move({ workspace = \"5\", follow = false })")
        (m "SHIFT + 6" "hl.dsp.window.move({ workspace = \"6\", follow = false })")
        (m "SHIFT + 7" "hl.dsp.window.move({ workspace = \"7\", follow = false })")
        (m "SHIFT + 8" "hl.dsp.window.move({ workspace = \"8\", follow = false })")

        # movewindow
        (m "SHIFT + K" "hl.dsp.window.move({ direction = \"up\" })")
        (m "SHIFT + J" "hl.dsp.window.move({ direction = \"down\" })")
        (m "SHIFT + left" "hl.dsp.window.move({ direction = \"left\" })")
        (m "SHIFT + right" "hl.dsp.window.move({ direction = \"right\" })")

        # layoutmsg
        (m "period" "hl.dsp.layout(\"move +col\")")
        (m "comma" "hl.dsp.layout(\"move -col\")")
        (m "equal" "hl.dsp.layout(\"colresize +0.2\")")
        (m "minus" "hl.dsp.layout(\"colresize -0.2\")")
        (m "P" "hl.dsp.layout(\"promote\")")
        (m "SHIFT + period" "hl.dsp.layout(\"swapcol r\")")
        (m "SHIFT + comma" "hl.dsp.layout(\"swapcol l\")")
        (m "SHIFT + H" "hl.dsp.layout(\"swapcol l\")")
        (m "SHIFT + L" "hl.dsp.layout(\"swapcol r\")")
        (m "M" "hl.dsp.layout(\"togglefit\")")

        # exec
        (m "RETURN" "hl.dsp.exec_cmd(\"wezterm\")")
        (m "E" "hl.dsp.exec_cmd(\"emacsclient -c -a 'emacs'\")")
        (m "SHIFT + S" "hl.dsp.exec_cmd(\"screenshot\")")
        (m "SHIFT + E" "hl.dsp.exec_cmd(\"screenshot-edit\")")
        (m "O" "hl.dsp.exec_cmd(\"obsidian\")")
        (m "space" "hl.dsp.exec_cmd(\"wofi --show drun -I\")")
        (k "CTRL + Print" "hl.dsp.exec_cmd(\"grim -o DP-1 ~/Pictures/screenshot.png\")")

        # bindm: arrastar / redimensionar com o mouse
        (m "mouse:272" "hl.dsp.window.drag()")
        (m "mouse:273" "hl.dsp.window.resize()")
      ];
    };
  };
}
