{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.discord;
in
{
  options.apps.discord = with types; {
    enable = mkBoolOpt false "Enable discord";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.discord.override {
        withOpenASAR = false;
        withVencord = true;
      })
      pkgs.xwaylandvideobridge
    ];
  };
}
