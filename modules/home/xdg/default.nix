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
      enable = mkEnableOption "xdg";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.xdg-user-dirs];
    xdg = {
      enable = true;
      portal.xdgOpenUsePortal = true;

      configFile = {"mimeapps.list".force = true;};
      mime.enable = true;
      mimeApps = {
        enable = true;
        defaultApplicationPackages = [
          config.programs.swayimg.package
          config.programs.firefox.package
          config.programs.zathura.package
          config.programs.helix.package
          config.programs.yazi.package
          config.programs.mpv.package
        ];
      };

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
    };
  };
}
