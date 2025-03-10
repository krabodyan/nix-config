{pkgs, ...}: {
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
    wl-gammactl
    wev
    xwayland
    wl-clipboard
  ];
}
