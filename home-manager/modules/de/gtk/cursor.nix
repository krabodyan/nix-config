{ config, pkgs, ... }:
{
  home = {
    pointerCursor = {
      package = pkgs.google-cursor;
      name = "GoogleDot-Blue";
      size = 16;
      gtk.enable = true;
      x11.enable = true;
    };
    sessionVariables = {
      XCURSOR_SIZE = config.home.pointerCursor.size;
      XCURSOR_THEME = config.home.pointerCursor.name;
    };
  };
}
