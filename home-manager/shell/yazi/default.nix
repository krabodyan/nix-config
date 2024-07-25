{
  xdg.mimeApps = {
    defaultApplications = {
      "inode/directory" = [ "yazi.desktop" ];
      "application/x-gnome-saved-search" = [ "yazi.desktop" ];
    };
  };
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      log = {
        enabled = false;
      };
      manager = {
        ratio = [
          0
          1
          1
        ];
        sort_dir_first = true;
        show_hidden = false;
        sort_by = "alphabetical";
        sort_sensitive = false;
        linemode = "mtime";
      };
      preview = {
        image_filter = "nearest";
        image_quality = 50;
        sixel_fraction = 20;
      };
    };
  };
  xdg.configFile."yazi/theme.toml".source = ./yazi.toml;
}
