{ pkgs, ... }: {
  imports = [
    ./bat
    ./yazi
    ./fish.nix
    ./htop.nix
    ./git.nix
    ./ufetch.nix
  ];
  home.packages = with pkgs; [
    pamixer
    brightnessctl
    xdg-utils
  ];
}
