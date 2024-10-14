{ pkgs, ... }:
{
  home.packages = with pkgs; [
    chromedriver
    chromium
  ];
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
        "onebar.disable-centering-of-URLbar" = false;
        "onebar.disable-https-truncate" = true;
        "onebar.disable-single-tab" = true;
        "onebar.hide-all-URLbar-icons" = true;
        "onebar.hide-all-tabs-button" = true;
        "onebar.hide-navigation-buttons" = true;
        "onebar.hide-unified-extensions-button" = false;
        "browser.warnOnQuit" = false;
        "browser.warnOnQuitShortcut" = false;
        "browser.download.always_ask_before_handling_new_types" = false;
        "browser.urlbar.trimHttps" = true;

        "general.smoothScroll" = true;
        "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
        "general.smoothScroll.msdPhysics.enabled" = true;
        "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
        "general.smoothScroll.msdPhysics.regularSpringConstant" = 650;
        "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 25;
        "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = "2";
        "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;
        "general.smoothScroll.currentVelocityWeighting" = "1";
        "general.smoothScroll.stopDecelerationWeighting" = "1";
        "mousewheel.default.delta_multiplier_y" = 300;

        "app.update.url" = "http://127.0.0.1/";
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
        "healthreport.uploadEnabled" = false;
        "social.toast-notifications.enabled" = false;
        "datareporting.healthreport.service.enabled" = false;
        "browser.slowStartup.notificationDisabled" = true;
        "gfx.xrender.enabled" = true;
        "webgl.disabled" = true;
        "browser.aboutConfig.showWarning" = false;
        "browser.translations.enable" = false;
        "browser.translations.automaticallyPopup" = false;

        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
        DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
        SearchBar = "unified"; # alternative: "separate"
      };
      userChrome = builtins.readFile ../../../assets/firefox.css;
    };
  };
}
