{ pkgs, ... }:
{
  xdg = {
    mimeApps.enable = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = false;
      config.common.default = "gtk";
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };
}
