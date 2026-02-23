{ lib, config, ... }:
let
  cfg = config.myHomeConfig.system;
in
{
  imports = [
    ./fonts
    ./nix
    ./privateFonts
    ./utils
  ];

  options.myHomeConfig.system = {
    enable = lib.mkEnableOption "system configuration and utilities";
    fonts.enable = lib.mkEnableOption "Public fonts";
    nixy.enable = lib.mkEnableOption "Nix-related tools and configuration";
    privateFonts.enable = lib.mkEnableOption "Private fonts";
    utils.enable = lib.mkEnableOption "System utilities";
  };

  config = lib.mkIf cfg.enable {
    fonts.enable = lib.mkDefault cfg.fonts.enable;
    nixy.enable = lib.mkDefault cfg.nixy.enable;
    privateFonts.enable = lib.mkDefault cfg.privateFonts.enable;
    utils.enable = lib.mkDefault cfg.utils.enable;
  };
}
