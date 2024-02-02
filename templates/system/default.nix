{ config
, pkgs
, ...
}: {
  imports = [ ./hardware-configuration.nix ];

  # Enable Bootloader (EFI or BIOS)
  #system.boot.efi.enable = true;
  #system.boot.bios.enable = true;

  # Better battery life on laptops
  # system.battery.enable = true;

  # suites.desktop.enable = true;
  # suites.development.enable = true;

  # suites.server.enable = true;

  # Nvidia Drivers
  # hardware.nvidia.enable = true;

  # Add packages (custom for ones in these dotfiles)
  # environment.systemPackages = with pkgs; [
  #   custom.package
  # ];

  # ======================== DO NOT CHANGE THIS ========================
  system.stateVersion = "22.11";
  # ======================== DO NOT CHANGE THIS ========================
}
