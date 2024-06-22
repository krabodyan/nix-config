{ pkgs, ...}: {
  imports = [
    ./foot.nix
    ./mpv.nix
    ./swappy.nix
    ./discord
    ./firefox.nix
    ./steam.nix
    ./64gram.nix
    ./zoom.nix
    ./protonvpn.nix
    ./office.nix
    ./ide.nix
  ];
  home.packages = with pkgs; [
    pcmanfm
    qbittorrent
    solaar
    gcolor3
    obs-studio
    kooha
    gimp
    system-config-printer
    pavucontrol
    feh
    # zathura
    swappy
    wf-recorder
  ];
}
