{ pkgs, ... }: {
  imports = [
    ./fish.nix
    ./python.nix
    ./bat.nix
    ./btop.nix
    ./ranger.nix
    ./git.nix
    ./fastfetch.nix
  ];
  home.packages = with pkgs; [ htop ninja gst_all_1.gstreamer];
}
