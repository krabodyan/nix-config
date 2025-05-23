{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.zoom;
in {
  options = {
    module.zoom = {
      enable = mkEnableOption "zoom";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.zoom-us.override {
        xdgDesktopPortalSupport = false;
        pulseaudioSupport = true;
      })
    ];
    xdg.mimeApps.defaultApplications = {
      "x-scheme-handler/zoommtg" = ["Zoom.desktop"];
    };
  };
}
