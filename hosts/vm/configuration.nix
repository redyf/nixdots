# Build this VM with nix build  ./#nixosConfigurations.vm.config.system.build.vm
# Then run is with: ./result/bin/run-nixos-vm
# To be able to connect with ssh enable port forwarding with:
# QEMU_NET_OPTS="hostfwd=tcp::2222-:22" ./result/bin/run-nixos-vm
# Then connect with ssh -p 2222 guest@localhost
{ nixpkgs, lib, config, pkgs, ... }:
{
  # Internationalisation options
  i18n.defaultLocale = "pt_BR.UTF-8";
  console.keyMap = "br-abnt2";

  # Options for the screen
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096;
      cores = 4;
      resolution = {
        x = 1280;
        y = 1024;
      };
      qemu.options = [
        # Better display option
        "-vga virtio"
        "-display gtk,zoom-to-fit=false"
        # Enable copy/paste
        # https://www.kraxel.org/blog/2021/05/qemu-cut-paste/
        "-chardev qemu-vdagent,id=ch1,name=vdagent,clipboard=on"
        "-device virtio-serial-pci"
        "-device virtserialport,chardev=ch1,id=ch1,name=com.redhat.spice.0"
      ];
    };
  };

  programs.zsh.enable = true;

  # A default user able to use sudo
  users = {
    users.guest = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "guest";
      group = "guest";
    };
  };
  users.groups.guest = { };

  security.sudo.wheelNeedsPassword = false;

  # X configuration
  services.xserver.enable = true;
  services.xserver.layout = "br";

  services.xserver.displayManager.autoLogin.user = "guest";
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.desktopManager.xfce.enableScreensaver = false;

  services.xserver.videoDrivers = [ "qxl" ];

  # For copy/paste to work
  services.spice-vdagentd.enable = true;

  # Enable ssh
  services.sshd.enable = true;

  # Included packages here
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    firefox
    neovim
    wget
  ];

  system.stateVersion = "22.11";
}
