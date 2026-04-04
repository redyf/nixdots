{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    (writeShellScriptBin "screenshot" ''
      grim -g "$(slurp)" - | wl-copy
    '')

    (writeShellScriptBin "screenshot-edit" ''
      wl-paste | swappy -f -
    '')
  ];
}
