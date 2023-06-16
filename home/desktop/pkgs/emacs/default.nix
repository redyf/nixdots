{
  config,
  pkgs,
  lib,
  ...
}: {
  home = {
    sessionPath = ["${config.xdg.configHome}/emacs/bin"];
    sessionVariables = {
      DOOMDIR = "${config.xdg.configHome}/doom";
      DOOMLOCALDIR = "${config.xdg.configHome}/doom-local";
      DOOMPROFILELOADFILE = "${config.xdg.configHome}/doom-local/profiles.el";
    };
  };
  systemd.user.sessionVariables = config.home.sessionVariables;

  programs.emacs.extraPackages = epkgs: [
    epkgs.vterm
    epkgs.pdf-tools
    epkgs.auctex
  ];

  xdg.configFile = {
    "doom" = {
      source = ./doom;
      onChange = "${pkgs.writeShellScript "doom-change" ''
        export DOOMDIR="${config.home.sessionVariables.DOOMDIR}"
        export DOOMLOCALDIR="${config.home.sessionVariables.DOOMLOCALDIR}"
        export PATH="${lib.makeBinPath [pkgs.git]}:$PATH"
        export EMACS="${toString config.home.path}/bin/emacs"
        if [ ! -d "$DOOMLOCALDIR" ]; then
          ${config.xdg.configHome}/emacs/bin/doom install
        else
          ${config.xdg.configHome}/emacs/bin/doom sync -e
        fi
      ''}";
    };
    "emacs" = {
      source = pkgs.fetchgit {
        url = "https://github.com/doomemacs/doomemacs";
        rev = "4e105a95af9c4c7e86471e5566eb7a5ff776ec92";
        sha256 = "sha256-X6kCIc1PU0AZBSDhlyJ2Az3jgC6ZHiAfB2yuHDvIpQ4=";
      };
      onChange = "${pkgs.writeShellScript "doom-change" ''
        export DOOMDIR="${config.home.sessionVariables.DOOMDIR}"
        export DOOMLOCALDIR="${config.home.sessionVariables.DOOMLOCALDIR}"
        export PATH="${lib.makeBinPath [pkgs.git]}:$PATH"
        export EMACS="${toString config.home.path}/bin/emacs"
        if [ ! -d "$DOOMLOCALDIR" ]; then
          ${config.xdg.configHome}/emacs/bin/doom install
        else
          ${config.xdg.configHome}/emacs/bin/doom sync -e
        fi
      ''}";
    };
  };
}
