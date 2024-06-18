{ pkgs, lib, ... }: {
  imports = [
    ./os
    ./packages
    ./hardware
  ];
}
