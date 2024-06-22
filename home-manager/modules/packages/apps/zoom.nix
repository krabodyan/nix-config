{ pkgs, ...}: {
  home.packages = [ pkgs.zoom-us ];
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/zoommtg" = [ "Zoom.desktop" ];
  };
}
