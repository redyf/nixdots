{ lib, ... }:

{
  options.myConfig.services = {
    enable = lib.mkEnableOption "Enable Services configuration";
    autorandr = {
      enable = lib.mkEnableOption "Enable autorandr";
    };
    displayManager = {
      enable = lib.mkEnableOption "Enable displayManager";
    };
    flatpak = {
      enable = lib.mkEnableOption "Enable flatpak";
    };
    fstrim = {
      enable = lib.mkEnableOption "Enable fstrim";
    };
    input = {
      enable = lib.mkEnableOption "Enable input";
    };
    jackett = {
      enable = lib.mkEnableOption "Enable jackett";
    };
    tlp = {
      enable = lib.mkEnableOption "Enable tlp";
    };
    upower = {
      enable = lib.mkEnableOption "Enable Upower";
    };
  };

  imports = [
    ./autorandr.nix
    ./displayManager.nix
    ./flatpak.nix
    ./fstrim.nix
    ./input.nix
    ./jackett.nix
    ./tlp.nix
    ./upower.nix
  ];
}
