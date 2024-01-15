{ pkgs
, config
, lib
, ...
}: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "red";
    homeDirectory = "/home/red";
    stateVersion = "23.11";
  };

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
    ./cli
    ./dev
    ./system
    # ./themes
    # ./services
    # ./graphical
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
