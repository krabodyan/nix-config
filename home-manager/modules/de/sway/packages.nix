{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wlr-randr
    swaykbdd
    grim
    slurp
    wev
    xwayland
    wl-clipboard
    zathura
  ];
}
