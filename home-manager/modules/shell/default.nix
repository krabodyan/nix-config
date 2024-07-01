{ pkgs, ... }: {
  imports = [
    ./bat
    ./yazi
    ./nvchad
    #./nixvim
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
