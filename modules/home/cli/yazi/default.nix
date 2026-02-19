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
      csvkit
    ];

    programs.yazi = {
      enable = true;
      enableFishIntegration = false;
      shellWrapperName = "yy";
      plugins = {
        inherit (pkgs.yaziPlugins) piper ouch rsync mime-ext;
      };
      initLua =
        # lua
        ''
          require("sshfs"):setup({
            mount_dir = "/tmp/sshfs",
            password_attempts = 3,
            default_mount_point = "home",
          })
        '';
    };

    xdg.configFile = {
      "yazi/yazi.toml".source = ./yazi.toml;
      "yazi/theme.toml".source = ./theme.toml;
      "yazi/keymap.toml".source = ./keymap.toml;
      "yazi/plugins/sshfs.yazi/main.lua".source = "${inputs.sshfs-yazi}/main.lua";
    };
  };
}
