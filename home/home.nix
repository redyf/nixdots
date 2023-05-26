{
  inputs,
  config,
  nix-colors,
  pkgs,
  ...
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
    ./dev
    # ./pkgs
    ./system
    ./themes
    ./services
    ./terminal
    ./graphical
  ];

  home.sessionVariables.NIXOS_OZONE_WL = "1";

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
    # (import (builtins.fetchTarball {
    #   url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    # }))
    # (import ~/flake/overlays/firefox-overlay.nix)
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    # integrates nur within Home-Manager
    nur =
      import
      (builtins.fetchTarball {
        url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
        sha256 = "1sldim5r1glwq6xhwkxnmd1gn1vpizggdml8v6hkad7fh8c1a6qz";
      })
      {inherit pkgs;};
  };

  nixpkgs.config.allowUnfreePredicate = pkg: true;

  fonts.fontconfig.enable = true;

  # Add support for .local/bin
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
