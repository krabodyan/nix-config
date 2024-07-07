{ pkgs, ... }:
{
  xdg = {
    mimeApps.enable = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config.common.default = "gtk";
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };
}
