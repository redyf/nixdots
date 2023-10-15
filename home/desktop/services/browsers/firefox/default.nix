{pkgs, ...}: {
  # programs.firefox = {
  #   enable = true;
  # };
  #   profiles.default = {
  #     search.default = "DuckDuckGo";
  #     search.force = true;
  #     extensions = with pkgs.nur.repos.rycee.firefox-addons; [
  #       stylus
  #       clearurls
  #       darkreader
  #       i-dont-care-about-cookies
  #       refined-github
  #       ublock-origin
  #     ];
  #     settings = {
  #       "app.normandy.api_url" = "";
  #       "app.normandy.enabled" = false;
  #       "app.shield.optoutstudies.enabled" = false;
  #       "app.update.auto" = false;
  #       "beacon.enabled" = false;
  #       "breakpad.reportURL" = "";
  #       "browser.aboutConfig.showWarning" = false;
  #       "browser.cache.offline.enable" = false;
  #       "browser.crashReports.unsubmittedCheck.autoSubmit" = false;
  #       "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
  #       "browser.crashReports.unsubmittedCheck.enabled" = false;
  #       "browser.disableResetPrompt" = true;
  #       "browser.formfill.enable" = false;
  #       "browser.newtab.preload" = false;
  #       "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
  #       "browser.newtabpage.enabled" = false;
  #       "browser.newtabpage.enhanced" = false;
  #       "browser.newtabpage.introShown" = true;
  #       "browser.safebrowsing.appRepURL" = "";
  #       "browser.safebrowsing.blockedURIs.enabled" = false;
  #       "browser.safebrowsing.downloads.enabled" = false;
  #       "browser.safebrowsing.downloads.remote.enabled" = false;
  #       "browser.safebrowsing.downloads.remote.url" = "";
  #       "browser.safebrowsing.enabled" = false;
  #       "browser.safebrowsing.malware.enabled" = false;
  #       "browser.safebrowsing.phishing.enabled" = false;
  #       "browser.selfsupport.url" = "";
  #       "browser.send_pings" = false;
  #       "browser.sessionstore.privacy_level" = 0;
  #       "browser.shell.checkDefaultBrowser" = false;
  #       "browser.startup.homepage_override.mstone" = "ignore";
  #       "browser.tabs.crashReporting.sendReport" = false;
  #       "browser.tabs.firefox-view" = false;
  #       "browser.urlbar.groupLabels.enabled" = false;
  #       "browser.urlbar.quicksuggest.enabled" = false;
  #       "browser.urlbar.speculativeConnect.enabled" = false;
  #       "browser.urlbar.trimURLs" = false;
  #       "browser.warnOnQuitShortcut" = false;
  #       "datareporting.healthreport.service.enabled" = false;
  #       "datareporting.healthreport.uploadEnabled" = false;
  #       "datareporting.policy.dataSubmissionEnabled" = false;
  #       "device.sensors.ambientLight.enabled" = false;
  #       "device.sensors.enabled" = false;
  #       "device.sensors.motion.enabled" = false;
  #       "device.sensors.orientation.enabled" = false;
  #       "device.sensors.proximity.enabled" = false;
  #       "dom.battery.enabled" = false;
  #       "dom.security.https_only_mode" = true;
  #       "dom.security.https_only_mode_ever_enabled" = true;
  #       "dom.webaudio.enabled" = false;
  #       "experiments.activeExperiment" = false;
  #       "experiments.enabled" = false;
  #       "experiments.manifest.uri" = "";
  #       "experiments.supported" = false;
  #       "extensions.CanvasBlocker@kkapsner.de.whiteList" = "";
  #       "extensions.ClearURLs@kevinr.whiteList" = "";
  #       "extensions.Decentraleyes@ThomasRientjes.whiteList" = "";
  #       "extensions.FirefoxMulti-AccountContainers@mozilla.whiteList" = "";
  #       "extensions.TemporaryContainers@stoically.whiteList" = "";
  #       "extensions.autoDisableScopes" = 14;
  #       "extensions.getAddons.cache.enabled" = false;
  #       "extensions.getAddons.showPane" = false;
  #       "extensions.pocket.enabled" = false;
  #       "extensions.shield-recipe-client.api_url" = "";
  #       "extensions.shield-recipe-client.enabled" = false;
  #       "extensions.webservice.discoverURL" = "";
  #       "media.autoplay.default" = 1;
  #       "media.autoplay.enabled" = false;
  #       "media.eme.enabled" = false;
  #       "media.gmp-widevinecdm.enabled" = false;
  #       "media.navigator.enabled" = false;
  #       "media.peerconnection.enabled" = false;
  #       "media.video_stats.enabled" = false;
  #       "network.IDN_show_punycode" = true;
  #       "network.allow-experiments" = false;
  #       "network.captive-portal-service.enabled" = false;
  #       "network.cookie.cookieBehavior" = 1;
  #       "network.dns.disablePrefetch" = true;
  #       "network.dns.disablePrefetchFromHTTPS" = true;
  #       "network.http.referer.spoofSource" = true;
  #       "network.http.speculative-parallel-limit" = 0;
  #       "network.predictor.enable-prefetch" = false;
  #       "network.predictor.enabled" = false;
  #       "network.prefetch-next" = false;
  #       "pdfjs.enableScripting" = false;
  #       "privacy.donottrackheader.enabled" = true;
  #       "privacy.donottrackheader.value" = 1;
  #       "privacy.query_stripping" = true;
  #       "privacy.trackingprotection.cryptomining.enabled" = true;
  #       "privacy.trackingprotection.enabled" = true;
  #       "privacy.trackingprotection.fingerprinting.enabled" = true;
  #       "privacy.trackingprotection.pbmode.enabled" = true;
  #       "privacy.usercontext.about_newtab_segregation.enabled" = true;
  #       "security.ssl.disable_session_identifiers" = true;
  #       "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" = false;
  #       "signon.autofillForms" = false;
  #       "toolkit.telemetry.archive.enabled" = false;
  #       "toolkit.telemetry.bhrPing.enabled" = false;
  #       "toolkit.telemetry.cachedClientID" = "";
  #       "toolkit.telemetry.enabled" = false;
  #       "toolkit.telemetry.firstShutdownPing.enabled" = false;
  #       "toolkit.telemetry.hybridContent.enabled" = false;
  #       "toolkit.telemetry.newProfilePing.enabled" = false;
  #       "toolkit.telemetry.prompted" = 2;
  #       "toolkit.telemetry.rejected" = true;
  #       "toolkit.telemetry.reportingpolicy.firstRun" = false;
  #       "toolkit.telemetry.server" = "";
  #       "toolkit.telemetry.shutdownPingSender.enabled" = false;
  #       "toolkit.telemetry.unified" = false;
  #       "toolkit.telemetry.unifiedIsOptIn" = false;
  #       "toolkit.telemetry.updatePing.enabled" = false;
  #       "webgl.disabled" = true;
  #       "webgl.renderer-string-override" = " ";
  #       "webgl.vendor-string-override" = " ";
  #     };
  #   };
  # };

  # xdg.mimeApps = {
  #   enable = true;
  #   associations.added = {
  #     "application/pdf" = ["org.gnome.Evince.desktop"];
  #     "video/mp4" = ["google-chrome.desktop"];
  #     "x-scheme-handler/http" = ["google-chrome.desktop"];
  #     "x-scheme-handler/https" = ["google-chrome.desktop"];
  #     "text/html" = ["google-chrome.desktop"];
  #   };
  #   defaultApplications = {
  #     "application/pdf" = ["org.gnome.Evince.desktop"];
  #     "application/x-extension-htm" = ["google-chrome.desktop"];
  #     "application/x-extension-html" = ["google-chrome.desktop"];
  #     "application/x-extension-shtml" = ["google-chrome.desktop"];
  #     "application/x-extension-xht" = ["google-chrome.desktop"];
  #     "application/x-extension-xhtml" = ["google-chrome.desktop"];
  #     "application/x-www-browser" = ["google-chrome.desktop"];
  #     "application/xhtml+xml" = ["google-chrome.desktop"];
  #     "text/html" = ["google-chrome.desktop"];
  #     "x-scheme-handler/chrome" = ["google-chrome.desktop"];
  #     "x-scheme-handler/http" = ["google-chrome.desktop"];
  #     "x-scheme-handler/https" = ["google-chrome.desktop"];
  #     "x-scheme-handler/ftp" = ["google-chrome.desktop"];
  #     "x-scheme-handler/about" = ["google-chrome.desktop"];
  #     "x-scheme-handler/unknown" = ["google-chrome.desktop"];
  #     "x-scheme-handler/webcal" = ["google-chrome.desktop"];
  #     "x-www-browser" = ["google-chrome.desktop"];
  #     "video/mp4" = ["google-chrome.desktop"];
  #     "browser" = ["google-chrome.desktop"];
  #   };
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
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/html" = "brave-browser.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
      "x-scheme-handler/about" = "brave-browser.desktop";
      "x-scheme-handler/unknown" = "brave-browser.desktop";
    };
  };
}
