{ lib, ... }:

{
  options.myConfig.system = {
    enable = lib.mkEnableOption "Enable programs configuration";

    amd = {
      enable = lib.mkEnableOption "Enable amd module";
    };

    ananicy = {
      enable = lib.mkEnableOption "Enable ananicy daemon";
    };

    audio = {
      enable = lib.mkEnableOption "Enable audio";
    };

    boot = {
      enable = lib.mkEnableOption "Enable boot";
    };

    cachy = {
      enable = lib.mkEnableOption "Enable CachyOS Kernel";
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

    kernel = {
      enable = lib.mkEnableOption "Enable kernel settings";
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
    ./amd.nix
    ./ananicy.nix
    ./audio.nix
    ./boot.nix
    ./cachy.nix
    ./environment.nix
    ./hardware.nix
    ./intel.nix
    ./kernel.nix
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
