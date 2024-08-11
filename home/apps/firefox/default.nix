{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    firefox.enable = lib.mkEnableOption "Enable firefox module";
  };
  config = lib.mkIf config.firefox.enable {
    programs.firefox = {
      enable = true;
      package = inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin;
      # Privacy about:config settings
      # profiles.redyf = {
      #   settings = {
      #     "browser.compactmode.show" = true;
      #     "browser.send_pings" = false;
      #     "browser.urlbar.speculativeConnect.enabled" = false;
      #     "dom.event.clipboardevents.enabled" = true;
      #     "media.navigator.enabled" = false;
      #     "network.cookie.cookieBehavior" = 1;
      #     "network.http.referer.XOriginPolicy" = 2;
      #     "network.http.referer.XOriginTrimmingPolicy" = 2;
      #     "beacon.enabled" = false;
      #     "browser.safebrowsing.downloads.remote.enabled" = false;
      #     "network.IDN_show_punycode" = true;
      #     "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      #     "app.shield.optoutstudies.enabled" = false;
      #     "dom.security.https_only_mode_ever_enabled" = true;
      #     "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      #     "browser.toolbars.bookmarks.visibility" = "never";
      #     "geo.enabled" = false;
      #
      #     # Disable telemetry
      #     "browser.newtabpage.activity-stream.feeds.telemetry" = false;
      #     "browser.ping-centre.telemetry" = false;
      #     "browser.tabs.crashReporting.sendReport" = false;
      #     "devtools.onboarding.telemetry.logged" = false;
      #     "toolkit.telemetry.enabled" = false;
      #     "toolkit.telemetry.unified" = false;
      #     "toolkit.telemetry.server" = "";
      #
      #     # Disable Pocket
      #     "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
      #     "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
      #     "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
      #     "browser.newtabpage.activity-stream.showSponsored" = false;
      #     "extensions.pocket.enabled" = false;
      #
      #     # Disable prefetching
      #     "network.dns.disablePrefetch" = true;
      #     "network.prefetch-next" = false;
      #
      #     # Disable JS in PDFs
      #     "pdfjs.enableScripting" = false;
      #
      #     # Harden SSL 
      #     "security.ssl.require_safe_negotiation" = true;
      #
      #     # Extra
      #     "identity.fxaccounts.enabled" = false;
      #     "browser.search.suggest.enabled" = false;
      #     "browser.urlbar.shortcuts.bookmarks" = false;
      #     "browser.urlbar.shortcuts.history" = false;
      #     "browser.urlbar.shortcuts.tabs" = false;
      #     "browser.urlbar.suggest.bookmark" = false;
      #     "browser.urlbar.suggest.engines" = false;
      #     "browser.urlbar.suggest.history" = false;
      #     "browser.urlbar.suggest.openpage" = false;
      #     "browser.urlbar.suggest.topsites" = false;
      #     "browser.uidensity" = 1;
      #     "media.autoplay.enabled" = false;
      #     "toolkit.zoomManager.zoomValues" = ".8,.90,.95,1,1.1,1.2";
      #
      #     "privacy.firstparty.isolate" = true;
      #     "network.http.sendRefererHeader" = 0;
      #   };
      #   userChrome = "
      #   * { 
      #       box-shadow: none !important;
      #       border: 0px solid !important;
      #   }
      #
      #   #tabbrowser-tabs {
      #       --user-tab-rounding: 8px;
      #   }
      #
      #   .tab-background {
      #       border-radius: var(--user-tab-rounding) var(--user-tab-rounding) 0px 0px !important; /* Connected */
      #       margin-block: 1px 0 !important; /* Connected */
      #   }
      #   #scrollbutton-up, #scrollbutton-down { /* 6/10/2021 */
      #       border-top-width: 1px !important;
      #       border-bottom-width: 0 !important;
      #   }
      #
      #   .tab-background:is([selected], [multiselected]):-moz-lwtheme {
      #       --lwt-tabs-border-color: rgba(0, 0, 0, 0.5) !important;
      #       border-bottom-color: transparent !important;
      #   }
      #   [brighttext='true'] .tab-background:is([selected], [multiselected]):-moz-lwtheme {
      #       --lwt-tabs-border-color: rgba(255, 255, 255, 0.5) !important;
      #       border-bottom-color: transparent !important;
      #   }
      #
      #   /* Container color bar visibility */
      #   .tabbrowser-tab[usercontextid] > .tab-stack > .tab-background > .tab-context-line {
      #       margin: 0px max(calc(var(--user-tab-rounding) - 3px), 0px) !important;
      #   }
      #
      #   #TabsToolbar, #tabbrowser-tabs {
      #       --tab-min-height: 29px !important;
      #   }
      #   #main-window[sizemode='true'] #toolbar-menubar[autohide='true'] + #TabsToolbar, 
      #   #main-window[sizemode='true'] #toolbar-menubar[autohide='true'] + #TabsToolbar #tabbrowser-tabs {
      #       --tab-min-height: 30px !important;
      #   }
      #   #scrollbutton-up,
      #   #scrollbutton-down {
      #       border-top-width: 0 !important;
      #       border-bottom-width: 0 !important;
      #   }
      #
      #   #TabsToolbar, #TabsToolbar > hbox, #TabsToolbar-customization-target, #tabbrowser-arrowscrollbox  {
      #       max-height: calc(var(--tab-min-height) + 1px) !important;
      #   }
      #   #TabsToolbar-customization-target toolbarbutton > .toolbarbutton-icon, 
      #   #TabsToolbar-customization-target .toolbarbutton-text, 
      #   #TabsToolbar-customization-target .toolbarbutton-badge-stack,
      #   #scrollbutton-up,#scrollbutton-down {
      #       padding-top: 7px !important;
      #       padding-bottom: 6px !important;
      #   }
      # ";
      # };
      # profiles.test = {
      #   search.default = "Google";
      #   search.force = true;
      # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      #   darkreader
      #   decentraleyes
      #   clearurls
      #   stylus
      #   auto-tab-discard
      #   onepassword-password-manager
      #   vimium
      #   react-devtools
      #   ublock-origin
      # ];
      # };
      # xdg.mimeApps = {
      #   enable = true;
      #   associations.added = {
      #     "application/pdf" = ["firefox.desktop"];
      #     "video/mp4" = ["mpv.desktop"];
      #     "x-scheme-handler/http" = ["firefox.desktop"];
      #     "x-scheme-handler/https" = ["firefox.desktop"];
      #     "text/html" = ["firefox.desktop"];
      #   };
      #   defaultApplications = {
      #     "application/pdf" = ["firefox.desktop"];
      #     "application/x-extension-htm" = ["firefox.desktop"];
      #     "application/x-extension-html" = ["firefox.desktop"];
      #     "application/x-extension-shtml" = ["firefox.desktop"];
      #     "application/x-extension-xht" = ["firefox.desktop"];
      #     "application/x-extension-xhtml" = ["firefox.desktop"];
      #     "application/x-www-browser" = ["firefox.desktop"];
      #     "application/xhtml+xml" = ["firefox.desktop"];
      #     "text/html" = ["firefox.desktop"];
      #     "x-scheme-handler/chrome" = ["firefox.desktop"];
      #     "x-scheme-handler/http" = ["firefox.desktop"];
      #     "x-scheme-handler/https" = ["firefox.desktop"];
      #     "x-scheme-handler/ftp" = ["firefox.desktop"];
      #     "x-scheme-handler/about" = ["firefox.desktop"];
      #     "x-scheme-handler/unknown" = ["firefox.desktop"];
      #     "x-scheme-handler/webcal" = ["firefox.desktop"];
      #     "x-www-browser" = ["firefox.desktop"];
      #     "video/mp4" = ["mpv.desktop"];
      #   };
      # };
    };
  };
}
