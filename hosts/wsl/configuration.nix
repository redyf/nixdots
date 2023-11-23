{ lib, pkgs, config, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/minimal.nix"
  ];

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = "red";
    startMenuLaunchers = true;

    # Enable native Docker support
    # docker-native.enable = true;

    # Enable integration with Docker Desktop (needs to be installed)
    # docker-desktop.enable = true;
  };

  users = {
    users = {
      red = {
	isNormalUser = true;
      };
    };
  };

  wsl.nativeSystemd = true;
  networking = {
    hostName = "wsl";
};

  programs.git = {
   enable = true;
    config = {
      init = {defaultBranch = "main";};
      github.user = "redyf";
      core.editor = "nvim";
      pull.rebase = false;
    };
  };

environment.systemPackages = with pkgs; [
    git
    neovim
];


  # Enable nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "22.05";
}
