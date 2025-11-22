{ lib, ... }:

{
  options.myConfig.system = {
    enable = lib.mkEnableOption "Enable programs configuration";

    audio = {
      enable = lib.mkEnableOption "Enable audio";
    };

    boot = {
      enable = lib.mkEnableOption "Enable boot";
    };

    environment = {
      enable = lib.mkEnableOption "Enable environment";
    };

    hardware = {
      enable = lib.mkEnableOption "Enable hardware";
    };

    intel = {
      enable = lib.mkEnableOption "Enable intel kernel params";
    };

    keymap = {
      enable = lib.mkEnableOption "Enable keymap";
    };

    locale = {
      enable = lib.mkEnableOption "Enable locale";
    };

    mime-types = {
      enable = lib.mkEnableOption "Enable mime types";
    };

    networking = {
      enable = lib.mkEnableOption "Enable networking";
    };

    power-management = {
      enable = lib.mkEnableOption "Enable power-management";
    };

    security = {
      enable = lib.mkEnableOption "Enable security";
    };

    ssh = {
      enable = lib.mkEnableOption "Enable ssh";
    };

    systemd = {
      enable = lib.mkEnableOption "Enable systemd";
    };

    time = {
      enable = lib.mkEnableOption "Enable time";
    };

    xdg-portal = {
      enable = lib.mkEnableOption "Enable xdg-portal";
    };

    zram = {
      enable = lib.mkEnableOption "Enable zram";
    };
  };

  imports = [
    ./audio.nix
    ./boot.nix
    ./environment.nix
    ./hardware.nix
    ./intel.nix
    ./keymap.nix
    ./locale.nix
    ./mime-types.nix
    ./networking.nix
    ./power-management.nix
    ./security.nix
    ./ssh.nix
    ./systemd.nix
    ./time.nix
    ./xdg-portal.nix
    ./zram.nix
  ];
}
