{ pkgs, ... }:
{
  home.packages = with pkgs.jetbrains; [
    rust-rover
    #    pycharm-professional
    #   clion
  ];
}
