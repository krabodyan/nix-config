{ pkgs, ... }:
{
  imports = [
    ./bat
    ./yazi
    ./helix
    ./fish.nix
    ./htop.nix
    ./git.nix
    ./pfetch.nix
    ./tmux.nix
    ./ripgrep.nix
    ./fastfetch.nix
    ./zoxide.nix
    # ./rustfmt.nix
  ];

  home.packages = with pkgs; [
    xdg-utils
    iotop
    iftop
    python3
    # php
    # temurin-jre-bin-17 # minecraft
    dust
    duf
    eza
    cmus
    exiftool
  ];
}
