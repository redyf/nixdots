{ ... }: {
  home = {
    username = "redyf";
    homeDirectory = "/home/redyf";
    stateVersion = "22.11";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
  };

  # Imports
  imports = [
    ./apps
    ./cli
    ./cli-apps
    ./desktop
    ./dev
    ./system
    ./themes
    ./tools
  ];

  # Allow unfree packages + use overlays
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      # (import (builtins.fetchTarball {
      #   url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
      # }))
      (import ../../overlays/firefox-overlay.nix)
    ];
  };

  fonts.fontconfig.enable = true;

  # Add support for .local/bin
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
