{pkgs, ...}: {
  programs.google-chrome = {
    enable = true;
  };

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = ["org.gnome.Evince.desktop"];
      "video/mp4" = ["google-chrome.desktop"];
      "x-scheme-handler/http" = ["google-chrome.desktop"];
      "x-scheme-handler/https" = ["google-chrome.desktop"];
      "text/html" = ["google-chrome.desktop"];
    };
    defaultApplications = {
      "application/pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop"];
      "application/x-extension-htm" = ["google-chrome.desktop"];
      "application/x-extension-html" = ["google-chrome.desktop"];
      "application/x-extension-shtml" = ["google-chrome.desktop"];
      "application/x-extension-xht" = ["google-chrome.desktop"];
      "application/x-extension-xhtml" = ["google-chrome.desktop"];
      "application/x-www-browser" = ["google-chrome.desktop"];
      "application/xhtml+xml" = ["google-chrome.desktop"];
      "text/html" = ["google-chrome.desktop"];
      "x-scheme-handler/chrome" = ["google-chrome.desktop"];
      "x-scheme-handler/http" = ["google-chrome.desktop"];
      "x-scheme-handler/https" = ["google-chrome.desktop"];
      "x-scheme-handler/ftp" = ["google-chrome.desktop"];
      "x-scheme-handler/about" = ["google-chrome.desktop"];
      "x-scheme-handler/unknown" = ["google-chrome.desktop"];
      "x-scheme-handler/webcal" = ["google-chrome.desktop"];
      "x-www-browser" = ["google-chrome.desktop"];
      "video/mp4" = ["google-chrome.desktop"];
      "browser" = ["google-chrome.desktop"];
    };
  };
}
