{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/programs
    ../../modules/raspberry
    ../../modules/system/environment.nix
    ../../modules/system/keymap.nix
    ../../modules/system/locale.nix
    ../../modules/system/networking.nix
    ../../modules/system/nix.nix
    ../../modules/system/security.nix
    ../../modules/system/systemd.nix
    ../../modules/system/time.nix
    ../../modules/system/users.nix
    ../../modules/system/xdg-portal.nix
    ../../modules/system/zram.nix
    ../../modules/stylix.nix
  ];

  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
    };
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    git
    bluez
    bluez-tools
  ];

  # just for access after install to continue provisioning
  system.stateVersion = "23.11";
}
