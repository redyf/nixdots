{ lib, ... }:

{
  options.myConfig.modules = {
    enable = lib.mkEnableOption "Enable modules configuration";

    cli = {
      enable = lib.mkEnableOption "Enable cli module";
    };
    desktop = {
      enable = lib.mkEnableOption "Enable desktop module";
    };
    development = {
      enable = lib.mkEnableOption "Enable development module";
    };
    gaming = {
      enable = lib.mkEnableOption "Enable Steam gaming platform";
    };
    hardware = {
      enable = lib.mkEnableOption "Enable hardware module";
    };
    nix = {
      enable = lib.mkEnableOption "Enable nix module";
    };
    services = {
      enable = lib.mkEnableOption "Enable services module";
    };
    themes = {
      enable = lib.mkEnableOption "Enable themes module";
    };
    system = {
      enable = lib.mkEnableOption "Enable system module";
    };
    users = {
      enable = lib.mkEnableOption "Enable users module";
    };
    virtualization = {
      enable = lib.mkEnableOption "Enable virtualization module";
    };
  };
  imports = [
    ./cli
    ./desktop
    ./development
    ./gaming
    ./hardware
    ./nix
    ./services
    ./themes
    ./system
    ./users
    ./virtualization
  ];
}
