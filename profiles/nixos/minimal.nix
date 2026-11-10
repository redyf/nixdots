# Role: minimal — the public example: no secrets, NVIDIA or personal services.
{ lib, pkgs, ... }:
{
  myConfig = {
    cli.zsh.enable = lib.mkDefault true;
    nix.enable = lib.mkDefault true;

    services = {
      fstrim.enable = lib.mkDefault true;
      input.enable = lib.mkDefault true;
    };

    system = {
      audio.enable = lib.mkDefault true;
      environment.enable = lib.mkDefault true;
      graphics.enable = lib.mkDefault true;
      keymap.enable = lib.mkDefault true;
      locale.enable = lib.mkDefault true;
      mime-types.enable = lib.mkDefault true;
      networking.enable = lib.mkDefault true;
      security.enable = lib.mkDefault true;
      systemd.enable = lib.mkDefault true;
      time.enable = lib.mkDefault true;
      zram.enable = lib.mkDefault true;
    };
  };

  environment.systemPackages = with pkgs; [ git ];
}
