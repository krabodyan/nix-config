{ pkgs, ... }:
{
  home = {
    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
      gtk.enable = true;
      x11.enable = true;
      x11.defaultCursor = "X_cursor";
    };
  };
}
