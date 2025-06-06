{
  lib,
  pkgs,
  config,
  mkAssociations,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.firefox;
in {
  options = {
    module.firefox = {
      enable = mkEnableOption "firefox";
    };
  };
  config = mkIf cfg.enable {
    xdg.mimeApps.defaultApplications = mkAssociations {
      types = [
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/chrome"
        "x-scheme-handler/about"
        "x-scheme-handler/unknown"
        "application/xhtml+xml"
        "x-scheme-handler/ftp"
        "text/html"
        "application/xhtml+xml"
        "application/x-extension-xht"
        "application/x-extension-htm"
        "application/x-extension-html"
        "application/x-extension-shtml"
        "application/x-extension-xhtml"
      ];
      desktop = "firefox.desktop";
    };

    programs.firefox = {
      enable = true;
      package = pkgs.firefox-wayland;
      profiles.krabodyan = {
        settings = {
          "general.autoScroll" = false;
          "widget.use-xdg-desktop-portal.file-picker" = 1;
          "browser.urlbar.autoFill" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "media.webspeech.synth.enabled" = false;
          "privacy.webrtc.legacyGlobalIndicator" = false;
          "ui.key.menuAccessKeyFocuses" = false;
          "ui.key.accelKey" = 17; # 17 = ctrl, 18 = alt
          "ui.key.menuAccessKey" = 17;
          "extensions.pocket.enabled" = false;
          "browser.topsites.contile.enabled" = false;
          "browser.search.suggest.enabled" = false;
          "browser.urlbar.showSearchSuggestionsFirst" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" =
            false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" =
            false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" =
            false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" =
            false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.system.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.ffmpeg.encoder.enabled" = true;
          "security.sandbox.content.level" = 0;
          # "widget.wayland.opaque-region.enabled" = false;

          "svg.context-properties.content.enabled" = true;
          "layout.css.color-mix.enabled" = true;
          "layout.css.light-dark.enabled" = true;
          "browser.tabs.tabMinWidth" = 66;
          "browser.tabs.tabClipWidth" = 86;

          "layout.spellcheckDefault" = 0;
          "app.update.auto" = false;
          "app.update.service.enabled" = false;
          "browser.tabs.insertAfterCurrent" = true;
          "browser.in-content.dark-mode" = true;
          "ui.systemUsesDarkTheme" = 1;
          "datareporting.healthreport.uploadEnabled" = false;
          "browser.search.suggest.enabled.private" = true;

          "geo.enabled" = false;
          "geo.wifi.uri" = "";
          "browser.search.geoip.url" = "";
          "toolkit.telemetry.enabled" = false;

          "browser.urlbar.trimHttps" = true;
          "browser.download.useDownloadDir" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.addons" = false;
          "browser.urlbar.suggest.fakespot" = false;
          "browser.urlbar.suggest.clipboard" = false;
          "browser.urlbar.suggest.mdn" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.pocket" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.recentsearches" = false;
          "browser.urlbar.suggest.remotetab" = false;
          "browser.urlbar.suggest.topsites" = false;
          "browser.urlbar.suggest.trending" = false;
          "browser.urlbar.suggest.weather" = false;
          "browser.urlbar.suggest.yelp" = false;
          "browser.urlbar.suggest.searches" = true;

          "browser.warnOnQuit" = false;
          "browser.warnOnQuitShortcut" = false;
          "browser.download.always_ask_before_handling_new_types" = false;

          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
          DisplayMenuBar = "never"; # alternatives: "always", "never" or "default-on"
          SearchBar = "unified"; # alternative: "separate"
        };
        userChrome = builtins.readFile ./firefox.css;
      };
    };
  };
}
