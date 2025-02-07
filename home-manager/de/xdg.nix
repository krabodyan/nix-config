{ config, pkgs, ... }: {
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
    configFile = { "mimeapps.list".force = true; };
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config.common.default = "wlr";
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };
  };
}
