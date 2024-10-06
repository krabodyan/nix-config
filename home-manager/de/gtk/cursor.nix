{ pkgs, ... }:
{
  home = {
    pointerCursor = {
      package = pkgs.mint-cursor-themes;
      name = "Bibata-Modern-Ice";
      size = 20;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
