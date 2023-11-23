{
  inputs,
  pkgs,
  ...
}: {
  services.emacs = {
    enable = true;
    # package = pkgs.emacs29;
  };
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
    extraPackages = epkgs: [epkgs.vterm];
  };
}
