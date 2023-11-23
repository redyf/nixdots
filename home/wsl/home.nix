{
  pkgs,
  config,
  lib,
  ...
}: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "red";
    homeDirectory = "/home/red";
    stateVersion = "23.11";
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
    ./cli
    ./dev
    # ./pkgs
    ./system
    ./themes
    # ./services
    # ./graphical
  ];

  # Overlays
  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg: true;
      packageOverrides = pkgs: {
        # integrates nur within Home-Manager
        nur =
          import
          (builtins.fetchTarball {
            url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
            sha256 = "sha256:1gr3l5fcjsd7j9g6k9jamby684k356a36h82cwck2vcxf8yw8xa0";
          })
          {inherit pkgs;};
      };
    };
  };

  fonts.fontconfig.enable = true;

  # Add support for .local/bin
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
