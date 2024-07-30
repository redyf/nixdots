{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    # ../../modules/raspberry
    ../../modules/programs/zsh.nix
    ../../modules/programs/sway.nix
    ../../modules/system/environment.nix
    ../../modules/system/keymap.nix
    ../../modules/system/locale.nix
    ../../modules/system/networking.nix
    ../../modules/nix.nix
    ../../modules/system/security.nix
    ../../modules/system/systemd.nix
    ../../modules/system/time.nix
    ../../modules/system/xdg-portal.nix
    ../../modules/system/zram.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = false;
  };

  users.users = {
    ${username} = {
      isNormalUser = true;
      description = username;
      initialPassword = "123456";
      shell = pkgs.zsh;
      extraGroups = ["networkmanager" "wheel" "input" "docker" "kvm" "libvirtd"];
    };
  };

  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
    };
    xserver = {
      enable = true;
      displayManager.gdm.enable = false;
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
