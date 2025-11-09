{ lib, config, ... }:
let
  cfg = config.myHomeConfig.shells;
in
{
  imports = [
    ./nushell
    ./scripts
    ./zsh
  ];

  options.myHomeConfig.shells = {
    enable = lib.mkEnableOption "shell configurations";
    nushell.enable = lib.mkEnableOption "Nushell configuration";
    scripts.enable = lib.mkEnableOption "custom shell scripts";
    zsh.enable = lib.mkEnableOption "Zsh configuration";
  };

  config = lib.mkIf cfg.enable {
    nushell.enable = lib.mkDefault cfg.nushell.enable;
    scripts.enable = lib.mkDefault cfg.scripts.enable;
    zsh.enable = lib.mkDefault cfg.zsh.enable;
  };
}
