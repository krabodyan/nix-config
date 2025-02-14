{ pkgs, ... }: {
  imports = [
    ./foot.nix
    ./mpv.nix
    ./screenshot.nix
    ./discord.nix
    ./firefox.nix
    ./telegram.nix
    ./pdf.nix
    ./zoom.nix
    ./office.nix
    ./swayimg.nix
  ];

  home.packages = with pkgs; [
    fritzing
    qbittorrent
    solaar
    gcolor3
    obs-studio
    gimp
    system-config-printer
  ];
}
