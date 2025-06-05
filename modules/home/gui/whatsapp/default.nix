{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.whatsapp;
in {
  options = {
    module.whatsapp = {
      enable = mkEnableOption "whatsapp";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.altus];
    xdg.configFile."Altus/settings.json".text = builtins.toJSON {
      tabBar.value = false;
      tabBarPosition.value = "bottom";
      trayIcon.value = false;
      tabClosePrompt.value = false;
      closeToTray.value = false;
      exitPrompt.value = false;
      preventEnter.value = false;
      notificationBadge.value = true;
      launchMinimized.value = false;
      autoLaunch.value = false;
      autoHideMenuBar.value = true;
      showSaveDialog.value = true;
      defaultDownloadDir.value = "";
      customTitlebar.value = false;
      systemScrollbars.value = false;
      rememberWindowSize.value = true;
      rememberWindowPosition.value = false;
      language.value = "en";
    };
  };
}
