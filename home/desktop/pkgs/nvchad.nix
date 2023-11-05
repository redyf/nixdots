{nixpkgs ? <nixpkgs>}: let
  pkgs = import nixpkgs {};
  pname = "nvchad";
  version = "2.0";

  src = pkgs.fetchFromGitHub {
    owner = "NvChad";
    repo = "NvChad";
    rev = "refs/heads/v${version}";
    sha256 = "04h6dahcqmk5plviv7ra30ilgj2fgrnf1nc4r5ndkaw7lrqkp5dv";
  };

  launcher = pkgs.writeScript "nvchad" ''
    export PATH="${pkgs.lib.makeBinPath [pkgs.coreutils pkgs.neovim pkgs.ripgrep pkgs.fd pkgs.ueberzug]}"
    export XDG_CONFIG_HOME=$(mktemp -d)

    # FIXME: Use the real XDG_CONFIG_HOME or fallback to $HOME/.config
    mkdir -p $HOME/.config/nvchad

    # Set up a disposable XDG_CONFIG_HOME
    mkdir $XDG_CONFIG_HOME/nvim
    ln -s ${src}/LICENSE $XDG_CONFIG_HOME/nvim/LICENSE
    ln -s ${src}/README.md $XDG_CONFIG_HOME/nvim/README.md
    ln -s ${src}/init.lua $XDG_CONFIG_HOME/nvim/init.lua
    cp -r ${src}/lua $XDG_CONFIG_HOME/nvim/lua
    chmod u+w $XDG_CONFIG_HOME/nvim/lua
    ln -s $HOME/.config/nvchad $XDG_CONFIG_HOME/nvim/lua/custom

    # Copy the initial user configuration, if it doesn't already exist.
    cp -n ${src}/lua/chadrc.lua $HOME/.config/nvchad/

    exec nvim "$@"
  '';
in
  pkgs.stdenv.mkDerivation rec {
    inherit src version pname;

    installPhase = ''
      mkdir -p $out/bin
      ln -s ${launcher} $out/bin/nvchad
    '';
  }
