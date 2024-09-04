{
  inputs,
  system,
  ...
}:
let
  client = inputs.ayugram.packages.${system}.ayugram-desktop;
  name = "com.ayugram.desktop";
  exec = "ayugram-desktop";
in
{
  home.packages = [
    client
  ];

  xdg.desktopEntries.${name} = {
    name = "Telegram Desktop";
    exec = "env QT_QPA_PLATFORMTHEME=gtk3 ${exec} -- %u";
  };
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/tg" = [ "${name}.desktop" ];
  };

}
