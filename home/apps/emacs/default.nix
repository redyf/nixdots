{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    emacs.enable = lib.mkEnableOption "Enable emacs module";
  };
  config = lib.mkIf config.emacs.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs.override {
        withGTK3 = true;
        withPgtk = true; # true on wayland
        withNativeCompilation = true;
        withTreeSitter = true;
      };
    };
    services.emacs = {
      enable = true;
      package = pkgs.emacs; # replace with emacs-gtk, or a version provided by the community overlay if desired.
    };
  };
}
