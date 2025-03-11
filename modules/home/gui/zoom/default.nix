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
      enable = mkEnableOption "enable zoom";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.zoom-us];
    xdg.mimeApps.defaultApplications = {
      "x-scheme-handler/zoommtg" = ["Zoom.desktop"];
    };
  };
}
