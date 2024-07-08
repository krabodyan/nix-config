{ pkgs, lib, ... }:
{
  imports = [
    ./foot.nix
    ./mpv.nix
    ./swappy.nix
    ./discord
    ./firefox.nix
    ./64gram.nix
    ./zathura.nix
    #./zoom.nix
    #./protonvpn.nix
    #./office.nix
    #./ide.nix
    ./swayimg.nix
    ./vscode.nix
  ];

  nixpkgs.config.allowUnfreePredicate = (_: true);

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
    zathura
    wf-recorder
    adwsteamgtk
  ];
}
