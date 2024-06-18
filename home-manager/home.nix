{ config, lib, pkgs, inputs, ... }: {
  home = {
    username = "krabodyan";
    homeDirectory = "/home/krabodyan";
    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  news.display = "silent";
  imports = [
    ./modules
    ./options.nix
  ];
}
