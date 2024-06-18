{ pkgs, ...}: {
  home.packages = with pkgs; [
    pcmanfm
    qbittorrent
    deluge
    solaar
    gcolor3
    #obs-studio
    kooha

    pavucontrol
    pamixer

    feh
    zathura


    brightnessctl
    swaybg
    hyprshot
    hyprpicker
    grim
    slurp
    swappy

    wev
    xwayland
    wl-clipboard
    wl-clipboard-x11
    wf-recorder

    xdg-utils
  ];
}
