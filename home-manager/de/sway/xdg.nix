{ pkgs, ... }:
{
  xdg = {
    mimeApps.enable = true;
    configFile."mimeapps.list".force = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = false;
      # config.wlr.de = {
      #   chooser_type = "dmenu";
      #   chooser_cmd = "${pkgs.rofi-wayland}/bin/rofi -dmenu";
      # };
      config.common.default = "wlr";
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        # xdg-desktop-portal-gtk
      ];
    };
  };
}
