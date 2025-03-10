{pkgs, ...}: {
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
    ./zoxide.nix
    ./tmux.nix
  ];
  home.packages = with pkgs; [
    jq # fish done
    eza
    tmux
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
    android-tools
    pulsemixer
    # ngrok
  ];
}
