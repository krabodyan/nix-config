{
  lib,
  fonts,
  config,
  colors,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.discord;
in {
  options = {
    module.discord = {
      enable = mkEnableOption "discord";
    };
  };
  config = mkIf cfg.enable {
    programs.vesktop = {
      enable = true;
      settings = with colors.hex; {
        appBadge = false;
        arRPC = false;
        checkUpdates = true;
        customTitleBar = false;
        disableMinSize = true;
        discordBranch = "stable";
        hardwareAcceleration = true;
        minimizeToTray = false;
        splashBackground = bg;
        splashColor = overlay1;
        splashTheming = true;
        staticTitle = true;
        tray = false;
        audio.granularSelect = true;
      };
      vencord = {
        useSystem = false;
        themes.custom =
          # css
          ''
            * {
              font-family: "${fonts.monospace}" !important;
              font-weight: bold !important;
              font-size: 15px !important;
            }
          '';
        settings = {
          enabledThemes = ["custom.css"];
          autoUpdate = true;
          frameless = true;
          autoUpdateNotification = false;
          notifyAboutUpdates = false;
          useQuickCss = true;
          disableMinSize = false;

          plugins = {
            BadgeAPI.enabled = true;
            BiggerStreamPreview.enabled = true;
            ClearURLs.enabled = true;
            CtrlEnterSend.enabled = true;
            DisableCallIdle.enabled = true;
            NoF1.enabled = true;
            NoServerEmojis.enabled = true;
            NoTypingAnimation.enabled = true;
            UserSettingsAPI.enabled = true;
            WebScreenShareFixes.enabled = true;
            NewGuildSettings.enable = true;

            VolumeBooster = {
              enabled = true;
              multiplier = 0.8;
            };

            SilentTyping = {
              enabled = true;
              isEnabled = true;
              showIcon = false;
            };

            CustomIdle = {
              enabled = true;
              idleTimeout = 0;
            };

            FakeNitro = {
              enabled = true;
              enableEmojiBypass = true;
              enableStickerBypass = true;
              enableStreamQualityBypass = true;
              transformStickers = true;
              transformEmojis = true;
              transformCompoundSentence = false;
              emojiSize = 48;
              stickerSize = 160;
              useHyperLinks = true;
              hyperLinkText = "{{NAME}}";
              disableEmbedPermissionCheck = false;
            };

            ImageZoom = {
              enabled = true;
              size = 1200;
              zoom = 2.7;
              nearestNeighbour = false;
              square = true;
              zoomSpeed = 5;
              saveZoomValues = true;
              invertScroll = true;
            };
          };
        };
      };
    };
  };
}
