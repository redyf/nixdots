{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  networking = {
    hostName = "raspberry"; # Define your hostname.
    firewall.enable = false;
    wireless = {
      enable = true;
    };
  };

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";

  environment.systemPackages = with pkgs; [
    neovim
    curl
    git
    bluez
    bluez-tools
  ];

  users.users.selene = {
    isNormalUser = true;
    description = "My RaspberryPI Host";
    initialPassword = "123456";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel" "input" "docker" "kvm" "libvirtd"];
  };

  programs = {
  zsh.enable = true;
  };

  time.timeZone = "America/Bahia";
  console = {keyMap = "br-abnt2";};

  i18n = {
    defaultLocale = "pt_BR.UTF-8";
  };

  # just for access after install to continue provisioning

  system.stateVersion = "23.11";
}
