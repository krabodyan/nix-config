{
  home = {
    username = "krabodyan";
    homeDirectory = "/home/krabodyan";
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true;
  news.display = "silent";
  imports = [
    ./de
    ./test.nix
    ./packages
    ./shell
    ../lib/theme.nix
  ];
}
