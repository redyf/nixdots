{pkgs, ...}: {
  services.emacs = {
    enable = true;
    package = pkgs.emacs29; # replace with emacs-gtk, or a version provided by the community overlay if desired.
  };
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
    # extraPackages = epkgs: [epkgs.vterm];
  };
}
