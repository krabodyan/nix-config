{ pkgs, ... }: {
  imports = [
    ./etc
    # ./bar
    ./gtk
    # ./sway
    ./river
    ./scripts
    ./xdg.nix
    ./env.nix
  ];
  home.packages = with pkgs; [
    grim
    slurp
    wlr-randr
    wev
    xwayland
    wl-clipboard
    lswt
  ];
}
