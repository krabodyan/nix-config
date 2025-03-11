{
  lib,
  pkgs,
  colors,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.screenshot;
in {
  options = {
    module.screenshot = {
      enable = mkEnableOption "enable screenshot (satty)";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.satty];
    xdg.configFile."satty/config.toml".text = with colors.hex; ''
      [general]
      corner-roundness = 4
      fullscreen = true
      early-exit = true
      initial-tool = "arrow"
      copy-command = "wl-copy"
      annotation-size-factor = 0.5
      output-filename = "${config.xdg.userDirs.pictures}/%Y-%m-%d_%H:%M:%S.png"
      save-after-copy = false
      default-hide-toolbars = false
      primary-highlighter = "freehand"
      disable-notifications = true

      [font]
      family = "Roboto"
      style = "Bold"

      [color-palette]
      palette = [
        "${red}",
        "${yellow}",
        "${magenta}",
        "${blue}",
        "${fg}",
        "${green}",
        "${pink}"
      ]
    '';
  };
}
