{ inputs, system, ... }:
{
  home.packages = [ inputs.ayugram-pkgs.packages.${system}.ayugram-desktop ];
  xdg.desktopEntries."com.ayugram.desktop" = {
    name = "Telegram Desktop";
    exec = "env QT_QPA_PLATFORMTHEME=gtk3 ayugram-desktop -- %u";
  };
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/tg" = [ "com.ayugram.desktop.desktop" ];
  };
}
