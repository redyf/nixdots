{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.myConfig.gaming.steam;
in
{
  config = lib.mkIf (config.myConfig.gaming.enable && cfg.enable) {
    nixpkgs.overlays = [ inputs.millennium.overlays.default ];
    programs = {
      steam = {
        enable = true;
        package = pkgs.millennium-steam;
      };
      gamemode.enable = true;
    };
  };
}
