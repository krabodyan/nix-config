{ pkgs, ... }: {
  imports = [
    ./bat
    ./yazi
    ./helix
    ./fish
    ./htop.nix
    ./git.nix
    ./zellij.nix
    ./ripgrep.nix
    ./fastfetch.nix
    ./zoxide.nix
    ./rustfmt.nix
  ];
  home.packages = with pkgs; [
    jq # fish done
    nh
    eza
    xdg-utils
    iotop
    iftop
    termusic
    python3
    ffmpeg
    dust
    dua
    duf
    exiftool

    mangohud
    postgresql
    ngrok
  ];
}
