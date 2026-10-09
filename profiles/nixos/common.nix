# Role: common — baseline for every personal host (CLI, nix, core system).
{ lib, pkgs, ... }:
{
  myConfig = {
    cli = {
      enable = lib.mkDefault true;
      nh.enable = lib.mkDefault true;
      zsh.enable = lib.mkDefault true;
    };

    nix = {
      enable = lib.mkDefault true;
      nix.enable = lib.mkDefault true;
    };

    system = {
      enable = lib.mkDefault true;
      boot.enable = lib.mkDefault true;
      environment.enable = lib.mkDefault true;
      hardware.enable = lib.mkDefault true;
      keymap.enable = lib.mkDefault true;
      locale.enable = lib.mkDefault true;
      networking.enable = lib.mkDefault true;
      security.enable = lib.mkDefault true;
      ssh.enable = lib.mkDefault true;
      systemd.enable = lib.mkDefault true;
      time.enable = lib.mkDefault true;
      zram.enable = lib.mkDefault true;
    };
  };

  environment.systemPackages = with pkgs; [
    git
    ntfs3g
  ];
}
