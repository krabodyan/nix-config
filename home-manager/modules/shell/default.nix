{ pkgs, ... }: {
  imports = [
    ./fish.nix
    ./python.nix
    ./bat.nix
    ./btop.nix
    ./ranger.nix
    ./git.nix
    ./ufetch.nix
  ];
  home.packages = with pkgs; [ htop ];
}
