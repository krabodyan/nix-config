{ config, ... }: {
  xdg = {
    enable = true;
    userDirs = let mk = path: "${config.home.homeDirectory}/${path}";
    in {
      enable = true;
      desktop = mk "desktop";
      documents = mk "documents";
      download = mk "downloads";
      music = mk "music";
      pictures = mk "pictures";
      publicShare = mk "public";
      templates = mk "templates";
      videos = mk "videos";
    };
    mime.enable = true;
    mimeApps.enable = true;
    configFile = { "mimeapps.list".force = true; };
    portal.xdgOpenUsePortal = true;
  };
}
