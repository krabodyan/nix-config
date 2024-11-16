{ pkgs, ... }: {
  home.packages = [ pkgs.zoom-us pkgs.whatsie ];
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/zoommtg" = [ "Zoom.desktop" ];
  };
}
