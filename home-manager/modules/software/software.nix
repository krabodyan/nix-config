{ pkgs, ...}: {
  home.packages = with pkgs; [
    pcmanfm
    qbittorrent
    solaar
    gcolor3
    obs-studio
    v4l-utils
    kooha
    gimp

    system-config-printer
    gnome.simple-scan

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
    devenv
  ];
}
