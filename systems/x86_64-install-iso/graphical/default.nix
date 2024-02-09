_: {
  # Enable Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Disable wpa_supplicant
  networking.wireless.enable = false;
  # Enable NetworkManager
  networking.networkmanager.enable = true;

  suites.desktop.enable = true;
  suites.development.enable = true;
  services.ssh.enable = true;

  system.stateVersion = "22.11";
}
