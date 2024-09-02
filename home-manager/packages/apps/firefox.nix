{ pkgs, ... }:
{
  home.packages = [ pkgs.chromium ];
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles.krabodyan = {
      settings = {
        "general.autoScroll" = false;
        "browser.urlbar.autoFill" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "media.webspeech.synth.enabled" = false;
        "privacy.webrtc.legacyGlobalIndicator" = false;
        "ui.key.menuAccessKeyFocuses" = false;
        "extensions.pocket.enabled" = false;
        "browser.topsites.contile.enabled" = false;
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        # "media.ffmpeg.vaapi.enabled" = true;
        # "media.ffmpeg.encoder.enabled" = true;
        # "security.sandbox.content.level" = 0;
        # "widget.wayland.opaque-region.enabled" = false;

        # "svg.context-properties.content.enabled" = true;
        # "layout.css.color-mix.enabled" = true;
        # "layout.css.light-dark.enabled" = true;
        "browser.tabs.tabMinWidth" = 66;
        "browser.tabs.tabClipWidth" = 86;

        "layout.spellcheckDefault" = 0;
        "app.update.auto" = false;
        "app.update.service.enabled" = false;
        "browser.tabs.insertAfterCurrent" = true;
        "browser.in-content.dark-mode" = true;
        "ui.systemUsesDarkTheme" = 1;
        # "browser.startup.page" = 3;
        "datareporting.healthreport.uploadEnabled" = false;
        # "media.peerconnection.enabled" = false;
        "browser.search.suggest.enabled.private" = true;
        "geo.enabled" = false;
        "geo.wifi.uri" = "";
        "browser.search.geoip.url" = "";
        # "browser.send_pings.require_same_host" = true;
        "toolkit.telemetry.enabled" = false;
        # "default-browser-agent.enabled" = false;

        # "onebar.conditional-navigation-buttons" = false;
        "onebar.disable-centering-of-URLbar" = false;
        "onebar.disable-https-truncate" = true;
        "onebar.disable-single-tab" = true;
        "onebar.hide-all-URLbar-icons" = true;
        "onebar.hide-all-tabs-button" = true;
        "onebar.hide-navigation-buttons" = true;
        "onebar.hide-unified-extensions-button" = false;

        "browser.warnOnQuit" = false;
        "browser.warnOnQuitShortcut" = false;
        "browser.download.always_ask_before_handling_new_types" = true;
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisplayBookmarksToolbar = "always"; # alternatives: "always" or "newtab"
        DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
        SearchBar = "unified"; # alternative: "separate"
      };
      userChrome = builtins.readFile ../../../assets/firefox.css;
    };
  };
}
