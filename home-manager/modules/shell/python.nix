{ pkgs, ...}: {
  home.packages = with pkgs; [
    chromedriver
    yt-dlp
  ];
}
