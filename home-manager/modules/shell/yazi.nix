{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      log = {
        enabled = false;
      };
      manager = {
        sort_dir_first = true;
        show_hidden = false;
        sort_by = "alphabetical";
        sort_sensitive = false;
        linemode = "size";
      };
      preview = {
        image_quality = 50;
      };
    };
  };
}
