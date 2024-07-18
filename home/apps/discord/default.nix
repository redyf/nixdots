{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    discord.enable = lib.mkEnableOption "Enable discord module";
  };
  config = lib.mkIf config.discord.enable {
    home.packages = with pkgs; [
      vesktop
      # (discord.override {
      #   withOpenASAR = false;
      #   withVencord = true;
      # })
    ];
  };
}
