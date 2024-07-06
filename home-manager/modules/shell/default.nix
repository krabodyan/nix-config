{ pkgs, ... }:
{
  imports = [
    ./bat
    ./yazi
    ./helix
    ./fish.nix
    ./htop.nix
    ./git.nix
    ./ufetch.nix
    ./tmux.nix
    ./ripgrep.nix
  ];

  home.packages = with pkgs; [ xdg-utils ];
}
