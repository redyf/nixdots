{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.myConfig.programs.niri;
in
{
  config = lib.mkIf (config.myConfig.programs.enable && cfg.enable) {
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
      # portalPackage = with pkgs; xdg-desktop-portal;
    };
  };
}
