{ pkgs, ... }:
{
  imports = [
    ./bat
    ./yazi
    ./helix
    ./fish.nix
    ./htop.nix
    ./git.nix
    ./zellij.nix
    ./ripgrep.nix
    ./fastfetch.nix
    ./zoxide.nix
    ./rustfmt.nix
  ];

  home.packages = with pkgs; [
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
