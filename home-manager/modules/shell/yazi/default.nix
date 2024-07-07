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
          2
          3
          3
        ];
        sort_dir_first = true;
        show_hidden = false;
        sort_by = "alphabetical";
        sort_sensitive = false;
        linemode = "none";
      };
      preview = {
        image_quality = 50;
      };
    };
  };
  xdg.configFile."yazi/theme.toml".source = ./yazi.toml;
}
