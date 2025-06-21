{
  lib,
  pkgs,
  config,
  inputs,
  mkAssociations,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.yazi;
in {
  options = {
    module.yazi = {
      enable = mkEnableOption "yazi";
    };
  };
  config = mkIf cfg.enable {
    xdg.mimeApps.defaultApplications = mkAssociations {
      types = ["inode/directory" "application/x-gnome-saved-search"];
      desktop = "yazi.desktop";
    };

    home.packages = with pkgs; [
      ouch
      exiftool
    ];

    programs.yazi = {
      enable = true;
      enableFishIntegration = false;
    };

    xdg.configFile = {
      "yazi/yazi.toml".source = ./yazi.toml;
      "yazi/theme.toml".source = ./theme.toml;
      "yazi/keymap.toml".source = ./keymap.toml;
      "yazi/plugins/ouch.yazi/main.lua".source = "${inputs.yazi-plugin-ouch}/main.lua";
      "yazi/plugins/rsync.yazi/main.lua".source = "${inputs.yazi-plugin-rsync}/main.lua";
    };
  };
}
