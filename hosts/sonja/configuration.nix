{
  pkgs,
  username,
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
    ../../modules/nix.nix
    ../../modules/system/security.nix
    ../../modules/system/ssh.nix
    ../../modules/system/systemd.nix
    ../../modules/system/time.nix
    ../../modules/system/xdg-portal.nix
    ../../modules/system/xserver.nix
    ../../modules/system/zram.nix
    ../../modules/stylix.nix
  ];

  users.users = {
    ${username} = {
      isNormalUser = true;
      description = username;
      initialPassword = "123456";
      shell = pkgs.zsh;
      extraGroups = ["networkmanager" "wheel" "input" "docker" "kvm" "libvirtd"];
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
