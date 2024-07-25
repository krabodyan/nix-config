{ config, ... }:
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
    ./packages
    ./shell
    ../lib/theme.nix
  ];

  xdg = {
    enable = true;
    userDirs =
      let
        appendToHomeDir = path: "${config.home.homeDirectory}/${path}";
      in
      {
        enable = true;
        desktop = appendToHomeDir "desktop";
        documents = appendToHomeDir "documents";
        download = appendToHomeDir "downloads";
        music = appendToHomeDir "music";
        pictures = appendToHomeDir "pictures";
        publicShare = appendToHomeDir "public";
        templates = appendToHomeDir "templates";
        videos = appendToHomeDir "videos";
      };
  };
}
