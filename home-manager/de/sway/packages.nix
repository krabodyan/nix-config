{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wlr-randr
    wev
    xwayland
    wl-clipboard
  ];
}
