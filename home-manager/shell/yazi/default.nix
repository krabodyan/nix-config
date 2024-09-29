{ helpers, ... }:
{
  xdg.mimeApps.defaultApplications = helpers.mkAssociations {
    types = [
      "inode/directory"
      "application/x-gnome-saved-search"
    ];
    desktop = "yazi.desktop";
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
        image_quality = 80;
        sixel_fraction = 10;
      };
    };
  };
  xdg.configFile."yazi/theme.toml".source = ./yazi.toml;
  xdg.configFile."yazi/keymap.toml".source = ./keymap.toml;
  xdg.configFile."yazi/plugins/compress.yazi/init.lua".source = ./compress.lua;
}
