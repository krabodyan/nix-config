{ pkgs, ... }: {
  imports = [
    ./bat
    ./yazi
    ./nixvim
    ./fish.nix
    ./htop.nix
    ./git.nix
    ./ufetch.nix
    ./tmux.nix
  ];
  home.packages = with pkgs; [
    xdg-utils
  ];
}
