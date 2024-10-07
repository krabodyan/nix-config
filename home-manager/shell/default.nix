{ pkgs, ... }:
{
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
    xdg-utils
    iotop
    iftop
    python3
    ffmpeg
    # php
    dust
    dua
    duf
    eza
    exiftool
  ];
}
