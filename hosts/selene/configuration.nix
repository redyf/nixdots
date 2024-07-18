{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/raspberry-hardware.nix
    ../../modules/system/keymap.nix
    ../../modules/system/time.nix
    ../../modules/system/locale.nix
    ../../modules/system/xdg-portal.nix
    ../../modules/system/security.nix
    ../../modules/nix.nix
    ../../modules/stylix.nix
    ../../modules/programs
  ];

  # Overlays for raspberry-pi
  raspberry-pi-nix.uboot.enable = true;
  raspberry-pi-nix.libcamera-overlay.enable = false;

  networking = {
    hostName = "raspberry";
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
    neovim
    curl
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
