{ pkgs, ... }: {
  imports = [
    ./fish.nix
    ./python.nix
    ./bat.nix
    ./htop.nix
    ./ranger.nix
    ./git.nix
    ./ufetch.nix
  ];
  home.packages = with pkgs; [
    pamixer
    brightnessctl
    xdg-utils
    devenv
  ];
}
