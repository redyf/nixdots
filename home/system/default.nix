{ lib, config, ... }:
let
  cfg = config.myHomeConfig.system;
in
{
  imports = [
    ./fonts
    ./nix
    ./utils
  ];

  options.myHomeConfig.system = {
    enable = lib.mkEnableOption "system configuration and utilities";
    fonts.enable = lib.mkEnableOption "fonts configuration";
    nixy.enable = lib.mkEnableOption "Nix-related tools and configuration";
    utils.enable = lib.mkEnableOption "system utilities";
  };

  config = lib.mkIf cfg.enable {
    fonts.enable = lib.mkDefault cfg.fonts.enable;
    nixy.enable = lib.mkDefault cfg.nixy.enable;
    utils.enable = lib.mkDefault cfg.utils.enable;
  };
}
