{ config, ... }: {
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
        linemode = "mtime";
      };
      preview = {
        image_quality = 50;
      };
    };
  };
  xdg.configFile."yazi/theme.toml".source = ./yazi.toml;
}
