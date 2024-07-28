{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wlr-randr
    grim
    slurp
    wev
    xwayland
    wl-clipboard
    zathura
  ];
}
