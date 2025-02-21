{ pkgs, ... }: {
  imports = [
    ./bat
    ./fastfetch.nix
    ./fish
    ./git.nix
    ./helix
    ./htop.nix
    ./nh.nix
    ./ripgrep.nix
    ./rustfmt.nix
    ./yazi
    ./zellij.nix
    ./zoxide.nix
  ];
  home.packages = with pkgs; [
    jq # fish done
    eza
    xdg-utils
    # termusic
    python3
    ffmpeg
    dust
    dua
    duf
    exiftool

    mangohud
    # postgresql
    scrcpy
    pulsemixer
    # ngrok
  ];
}
