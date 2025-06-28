{
  lib,
  pkgs,
  config,
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
      csvkit
    ];

    programs.yazi = {
      enable = true;
      enableFishIntegration = false;
      plugins = {
        inherit (pkgs.yaziPlugins) piper ouch rsync;
      };
    };

    xdg.configFile = {
      "yazi/yazi.toml".source = ./yazi.toml;
      "yazi/theme.toml".source = ./theme.toml;
      "yazi/keymap.toml".source = ./keymap.toml;
    };
  };
}
