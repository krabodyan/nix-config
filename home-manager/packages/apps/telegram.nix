{ pkgs, ... }:
let
  client = pkgs.telegram-desktop;
  name = "org.telegram.desktop";
  exec = "telegram-desktop";
in {
  home.packages = [ client ];

  xdg.desktopEntries.${name} = {
    name = "Telegram Desktop";
    exec = "env QT_QPA_PLATFORMTHEME=gtk3 ${exec} -- %u";
  };
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/tg" = [ "${name}.desktop" ];
  };

}
