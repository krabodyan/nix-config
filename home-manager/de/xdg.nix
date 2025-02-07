{ config, pkgs, ... }:
let termfilechooser = (pkgs.callPackage ./termfilechooser.nix { });
in {
  xdg = {
    enable = true;
    userDirs =
      let appendToHomeDir = path: "${config.home.homeDirectory}/${path}";
      in {
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
    mime.enable = true;
    mimeApps.enable = true;
    configFile = {
      "mimeapps.list".force = true;
      "xdg-desktop-portal-termfilechooser/config".text = ''
        [filechooser]
        cmd=${termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
        default_dir=$HOME
      '';
    };
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config.common.default = "wlr";
      config.common."org.freedesktop.impl.portal.FileChooser" =
        [ "xdg-desktop-portal-termfilechooser" ];
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        termfilechooser
        xdg-desktop-portal-wlr
      ];
    };
  };
}
