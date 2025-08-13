{
  lib,
  config,
  pkgs,
  ...
}:
let
  minimalConfig = import ./minimal/config.nix {
    inherit config lib;
  };
  minimalStyle = import ./minimal/style.nix {
    inherit config lib;
  };
in
{
  options = {
    waybar.enable = lib.mkEnableOption "Enable waybar module";
  };
  config = lib.mkIf config.waybar.enable {
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
      settings = minimalConfig;
      style = minimalStyle;
    };
  };
}
