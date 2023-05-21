{ inputs
, config
, pkgs
, ...
}: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "redyf";
  home.homeDirectory = "/home/redyf";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Imports
  imports = [
    ./terminal
    ./themes
    ./pkgs
  ];

  # Overlays
  nixpkgs.overlays = [
    (self: super: {
      discord = super.discord.overrideAttrs (
        _: {
          src = builtins.fetchTarball {
            url = "https://discord.com/api/download?platform=linux&format=tar.gz";
          };
        }
      );
    })
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
    # (import (builtins.fetchTarball {
    #   url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    # }))
    # (import ~/flake/overlays/firefox-overlay.nix)
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.6"
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    # integrates nur within Home-Manager
    nur =
      import
        (builtins.fetchTarball {
          url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
          sha256 = "1gxaidh1iji0kkvmwaq6mli9wn9n592a1x2n8aqxaj0bfnf5wmak";
        })
        { inherit pkgs; };
  };

  nixpkgs.config.allowUnfreePredicate = pkg: true;

  fonts.fontconfig.enable = true;

  # Add support for .local/bin
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
