{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.xdg;
in {
  options = {
    module.xdg = {
      enable = mkEnableOption "enable xdg";
    };
  };
  config = mkIf cfg.enable {
    xdg = {
      enable = true;
      userDirs = let
        mk = path: "${config.home.homeDirectory}/${path}";
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
      configFile = {
        "mimeapps.list".force = true;
        "xdg-desktop-portal-termfilechooser/config".text = ''
          [filechooser]
          cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
          default_dir=${config.xdg.userDirs.download}
        '';
      };
      portal.xdgOpenUsePortal = true;
    };
  };
}
