{
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/programs
    ../../modules/raspberry
    ../../modules/system/audio.nix
    ../../modules/system/boot.nix
    ../../modules/system/environment.nix
    ../../modules/system/hardware.nix
    ../../modules/system/keymap.nix
    ../../modules/system/locale.nix
    ../../modules/system/networking.nix
    ../../modules/system/security.nix
    ../../modules/system/ssh.nix
    ../../modules/system/systemd.nix
    ../../modules/system/time.nix
    ../../modules/system/xdg-portal.nix
    # ../../modules/default.nix
    ../../modules/system/zram.nix
    # ../../modules/nix.nix
    # ../../modules/services.nix
    # ../../modules/stylix.nix
    # ../../modules/virtualisation.nix
  ];

  users.users = {
    ${username} = {
      isNormalUser = true;
      description = username;
      initialPassword = "123456";
      shell = pkgs.zsh;
      extraGroups = [
        "networkmanager"
        "wheel"
        "input"
        "docker"
        "kvm"
        "libvirtd"
      ];
    };
  };

  nixpkgs.config.allowUnsupportedSystem = true;

  environment.systemPackages = with pkgs; [
    git
    bluez
    bluez-tools
  ];

  # just for access after install to continue provisioning
  system.stateVersion = "23.11";
}
