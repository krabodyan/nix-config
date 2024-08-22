{
  inputs,
  system,
  pkgs,
  ...
}:
{
  home.packages = [
    # inputs.ayugram-desktop.packages.${system}.default
    pkgs.telegram-desktop
  ];
  xdg.desktopEntries."org.telegram.desktop" = {
    name = "Telegram Desktop";
    exec = "env QT_QPA_PLATFORMTHEME=gtk3 telegram-desktop -- %u";
  };
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
  };
  # home.packages = [ pkgs._64gram ];
  # xdg.desktopEntries."org.telegram.desktop" = {
  #   name = "Telegram Desktop";
  #   exec = "env QT_QPA_PLATFORMTHEME=gtk3 telegram-desktop -- %u";
  # };
  # xdg.mimeApps.defaultApplications = {
  #   "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
  # };
}
