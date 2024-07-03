{ pkgs, ... }: {
  home.packages = [ pkgs.chromedriver pkgs.chromium ]; # pkgs.google-chrome ];
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles.krabodyan.settings = {
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
      "media.ffmpeg.vaapi.enabled" = true;
      "security.sandbox.content.level" = 0;
      # "media.ffmpeg.encoder.enabled" = true;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
      DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
      SearchBar = "unified"; # alternative: "separate"
    };
  };
  xdg.mimeApps =
    let
      browser = "firefox.desktop";
      associations = {
        "text/html" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/ftp" = browser;
        "x-scheme-handler/about" = browser;
        "x-scheme-handler/unknown" = browser;
        "application/x-extension-htm" = browser;
        "application/x-extension-html" = browser;
        "application/x-extension-shtml" = browser;
        "application/xhtml+xml" = browser;
        "application/x-extension-xhtml" = browser;
        "application/x-extension-xht" = browser;
      };
    in
    {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
}
