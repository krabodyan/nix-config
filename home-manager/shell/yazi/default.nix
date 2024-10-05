{ helpers, pkgs, ... }:
{
  xdg.mimeApps.defaultApplications = helpers.mkAssociations {
    types = [
      "inode/directory"
      "application/x-gnome-saved-search"
    ];
    desktop = "yazi.desktop";
  };
  home.packages = [ pkgs.ouch ];
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
  };
  xdg.configFile."yazi/yazi.toml".source = ./yazi.toml;
  xdg.configFile."yazi/theme.toml".source = ./theme.toml;
  xdg.configFile."yazi/keymap.toml".source = ./keymap.toml;
  xdg.configFile."yazi/plugins/ouch.yazi/init.lua".source = ./plugins/ouch.lua;
}
