{ options
, config
, pkgs
, lib
, ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.firefox;
in
{
  options.apps.firefox = with types; {
    enable = mkBoolOpt false "Enable or disable firefox browser";
  };

  config = mkIf cfg.enable {
    home.extraOptions.programs.firefox = {
      enable = true;
    };
    #   home.programs.firefox = {
    #     enable = true;
    #     profiles.redyf = {
    #       search.default = "Google";
    #       search.force = true;
    #       extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    #         darkreader
    #         decentraleyes
    #         clearurls
    #         stylus
    #         auto-tab-discard
    #         vimium
    #         ublock-origin
    #       ];
    #     };
    #   };
    #
    #   xdg.mimeApps = {
    #     enable = true;
    #     associations.added = {
    #       "application/pdf" = ["firefox.desktop"];
    #       "video/mp4" = ["mpv.desktop"];
    #       "x-scheme-handler/http" = ["firefox.desktop"];
    #       "x-scheme-handler/https" = ["firefox.desktop"];
    #       "text/html" = ["firefox.desktop"];
    #     };
    #     defaultApplications = {
    #       "application/pdf" = ["firefox.desktop"];
    #       "application/x-extension-htm" = ["firefox.desktop"];
    #       "application/x-extension-html" = ["firefox.desktop"];
    #       "application/x-extension-shtml" = ["firefox.desktop"];
    #       "application/x-extension-xht" = ["firefox.desktop"];
    #       "application/x-extension-xhtml" = ["firefox.desktop"];
    #       "application/x-www-browser" = ["firefox.desktop"];
    #       "application/xhtml+xml" = ["firefox.desktop"];
    #       "text/html" = ["firefox.desktop"];
    #       "x-scheme-handler/chrome" = ["firefox.desktop"];
    #       "x-scheme-handler/http" = ["firefox.desktop"];
    #       "x-scheme-handler/https" = ["firefox.desktop"];
    #       "x-scheme-handler/ftp" = ["firefox.desktop"];
    #       "x-scheme-handler/about" = ["firefox.desktop"];
    #       "x-scheme-handler/unknown" = ["firefox.desktop"];
    #       "x-scheme-handler/webcal" = ["firefox.desktop"];
    #       "x-www-browser" = ["firefox.desktop"];
    #       "video/mp4" = ["mpv.desktop"];
    #     };
    #   };
  };
}
