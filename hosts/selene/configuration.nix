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
    ../../modules/system/keymap.nix
    ../../modules/system/time.nix
    ../../modules/system/locale.nix
    ../../modules/system/xdg-portal.nix
    ../../modules/system/security.nix
    ../../modules/system/zram.nix
    ../../modules/nix.nix
    ../../modules/stylix.nix
  ];

  networking = {
    hostName = "rpi5";
    networkmanager.enable = true;
    firewall.enable = false;
  };

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

  users.users = {
    selene = {
      isNormalUser = true;
      description = "selene";
      initialPassword = "123456";
      shell = pkgs.zsh;
      extraGroups = ["networkmanager" "wheel" "input" "docker" "kvm" "libvirtd"];
    };
  };

  # just for access after install to continue provisioning
  system.stateVersion = "23.11";
}
