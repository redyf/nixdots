{pkgs, ...}: {
  programs.google-chrome = {
    enable = true;
  };

  # xdg.enable = true;
  # xdg.mimeApps = {
  #   enable = true;
  #   defaultApplications = {
  #     "text/html" = "google-chrome-stable.desktop";
  #     "x-scheme-handler/http" = "google-chrome-stable.desktop";
  #     "x-scheme-handler/https" = "google-chrome-stable.desktop";
  #     "x-scheme-handler/about" = "google-chrome-stable.desktop";
  #     "x-scheme-handler/unknown" = "google-chrome-stable.desktop";
  #     "x-scheme-handler/chrome" = "google-chrome-stable.desktop";
  #     "application/x-extension-htm" = "google-chrome-stable.desktop";
  #     "application/x-extension-html" = "google-chrome-stable.desktop";
  #     "application/x-extension-shtml" = "google-chrome-stable.desktop";
  #     "application/xhtml+xml" = "google-chrome-stable.desktop";
  #     "application/x-extension-xhtml" = "google-chrome-stable.desktop";
  #     "application/x-extension-xht" = "google-chrome-stable.desktop";
  #     "application/x-www-browser" = "google-chrome-stable.desktop";
  #     "x-www-browser" = "google-chrome-stable.desktop";
  #     "x-scheme-handler/webcal" = "google-chrome-stable.desktop";
  #   };
  # };
}
