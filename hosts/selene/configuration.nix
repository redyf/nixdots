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
      iwd = {
        enable = true;
        settings.General.EnableNetworkConfiguration = true;
      };
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

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  time.timeZone = "America/Bahia";
  console = {keyMap = "br-abnt2";};

  i18n = {
    defaultLocale = "pt_BR.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };

  # just for access after install to continue provisioning

  system.stateVersion = "23.11";
}
