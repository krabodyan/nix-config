{
  CaptivePortal = false;
  DisableFirefoxScreenshots = true;
  DisableFirefoxStudies = true;
  DisableFormHistory = true;
  DisablePocket = true;
  DisableProfileRefresh = true;
  DisableSetDesktopBackground = true;
  DisableTelemetry = true;
  DisplayBookmarksToolbar = false;
  DontCheckDefaultBrowser = true;
  HardwareAcceleration = true;
  LegacyProfiles = true;
  ManualAppUpdateOnly = true;
  NetworkPrediction = false;
  PasswordManagerEnabled = false;
  PromptForDownloadLocation = false;

  ExtensionSettings = {
    "*".installation_mode = "force_installed";
  };

  FirefoxHome = {
    Pocket = false;
    Snippets = false;
  };

  SanitizeOnShutdown = {
    Cache = true;
    Cookies = false;
    Downloads = true;
    FormData = true;
    History = false;
    OfflineApps = true;
    Sessions = true;
  };
}
