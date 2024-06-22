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
}
