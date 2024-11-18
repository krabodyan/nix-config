{
  home = {
    username = "krabodyan";
    homeDirectory = "/home/krabodyan";
    stateVersion = "25.05";
  };
  programs.home-manager.enable = true;
  news.display = "silent";
  imports = [ ./de ./packages ./shell ../lib/theme.nix ];
}
