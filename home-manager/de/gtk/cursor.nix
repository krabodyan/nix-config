{ pkgs, ... }:
{
  home = {
    pointerCursor = {
      package = pkgs.vanilla-dmz;
      name = "DMZ-White";
      size = 20;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
