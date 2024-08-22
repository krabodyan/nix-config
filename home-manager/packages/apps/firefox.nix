{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles.krabodyan = {
      settings = {
        "general.autoScroll" = false;
        "browser.urlbar.autoFill" = false;
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
        "media.ffmpeg.encoder.enabled" = true;
        "security.sandbox.content.level" = 0;
        "widget.wayland.opaque-region.enabled" = false;

        "svg.context-properties.content.enabled" = true;
        "layout.css.color-mix.enabled" = true;
        "layout.css.light-dark.enabled" = true;
        "browser.tabs.tabMinWidth" = 66;
        "browser.tabs.tabClipWidth" = 86;
        "fp.tweak.autohide-bookmarks" = true;
        "fp.tweak.macos-button" = false;
        "fp.tweak.rounded-corners" = true;
        "fp.tweak.sidebar-enabled" = false;

        "layout.spellcheckDefault" = 0;
        "app.update.auto" = false;
        "app.update.service.enabled" = false;
        "browser.tabs.insertAfterCurrent" = true;
        "browser.in-content.dark-mode" = true;
        "ui.systemUsesDarkTheme" = 1;
        "browser.startup.page" = 3;
        "datareporting.healthreport.uploadEnabled" = false;
        "media.peerconnection.enabled" = false;
        "browser.search.suggest.enabled.private" = true;
        "geo.enabled" = false;
        "geo.wifi.uri" = "";
        "browser.search.geoip.url" = "";
        "browser.send_pings.require_same_host" = true;
        "toolkit.telemetry.enabled" = false;
        "default-browser-agent.enabled" = false;
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
        DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
        SearchBar = "unified"; # alternative: "separate"
      };
      userChrome = ''
        /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/toolbars_below_content.css made available under Mozilla Public License v. 2.0 */

        @-moz-document url(chrome://browser/content/browser.xhtml){
          
          #titlebar{ -moz-appearance: none !important; }

          #navigator-toolbox > div{ display: contents }
          .global-notificationbox,
          #mainPopupSet,
          #browser,
          #customization-container,
          #tab-notification-deck{
            order: -1;
          }

          #titlebar{
            order: 2;
          } 

          #toolbar-menubar{
            position: fixed;
            display: flex;
            width: 100vw;
            top: 0px;
            -moz-window-dragging: drag;
          }
          #navigator-toolbox{ border-bottom: none !important; }

          #toolbar-menubar > spacer{ flex-grow: 1 }

          #urlbar[breakout][breakout-extend]{
            display: flex !important;
            flex-direction: column-reverse;
            bottom: 0px !important; /* Change to 3-5 px if using compact_urlbar_megabar.css depending on toolbar density */
            top: auto !important;
          }

          .urlbarView-body-inner{ border-top-style: none !important; }

          #TabsToolbar > .titlebar-buttonbox-container{ display: none }
          #toolbar-menubar > .titlebar-buttonbox-container{ order: 1000 }

          .panel-viewstack{ max-height: unset !important; }

          :root[sizemode="fullscreen"] #navigator-toolbox{ margin-top: 0 !important }
          :root[sizemode="fullscreen"] #navigator-toolbox[style*="margin-top"]{ visibility: collapse }
          #fullscr-toggler{ bottom: 0; top: unset !important; }
          
          #navigator-toolbox{ bottom: 0px; transform-origin: bottom }
          #main-window > body > box{ margin-top: 0 !important; }
          #toolbar-menubar{ z-index: 1; background-color: var(--lwt-accent-color,black); }
          
          :root[BookmarksToolbarOverlapsBrowser] #navigator-toolbox{
            margin-block: calc(-1 * var(--bookmarks-toolbar-height)) 0 !important;
          }
          :root[BookmarksToolbarOverlapsBrowser] .newTabBrowserPanel{
            padding-block: 0 var(--bookmarks-toolbar-height) !important;
          }
          
          #titlebar{ flex-direction: column }
        }
      '';
    };
  };
}
