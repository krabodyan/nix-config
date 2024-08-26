{
  inputs,
  system,
  pkgs,
  lib,
  ...
}:
{
  home.packages = [
    # (pkgs.callPackage ./ayugram2.nix {
    #   inherit lib;
    #   inherit (pkgs)
    #     fetchFromGitHub
    #     stdenv
    #     telegram-desktop
    #     nix-update-script
    #     ;
    # })
    pkgs.materialgram
  ];
  xdg.desktopEntries."io.github.kukuruzka165.materialgram" = {
    name = "Telegram Desktop";
    exec = "env QT_QPA_PLATFORMTHEME=gtk3 materialgram -- %u";
  };
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/tg" = [ "io.github.kukuruzka165.materialgram.desktop" ];
  };
  # xdg.desktopEntries."org.telegram.desktop" = {
  #   name = "Telegram Desktop";
  #   exec = "env QT_QPA_PLATFORMTHEME=gtk3 telegram-desktop -- %u";
  # };
  # xdg.mimeApps.defaultApplications = {
  #   "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
  # };
  # home.packages = [ pkgs._64gram ];
  # xdg.desktopEntries."org.telegram.desktop" = {
  #   name = "Telegram Desktop";
  #   exec = "env QT_QPA_PLATFORMTHEME=gtk3 telegram-desktop -- %u";
  # };
  # xdg.mimeApps.defaultApplications = {
  #   "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
  # };
}
