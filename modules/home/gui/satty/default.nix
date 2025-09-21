{
  lib,
  pkgs,
  fonts,
  colors,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.satty;
in {
  options = {
    module.satty = {
      enable = mkEnableOption "screenshot tool (satty)";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [pkgs.satty];
    # TODO rewrite to module
    xdg.configFile."satty/config.toml".text = with colors.hex;
    # toml
      ''
        [general]
        corner-roundness = 4
        fullscreen = true
        early-exit = true
        initial-tool = "arrow"
        copy-command = "wl-copy"
        actions-on-escape = []
        no-window-decoration = true
        annotation-size-factor = 0.5
        output-filename = "${config.xdg.userDirs.pictures}/%Y-%m-%d_%H:%M:%S.png"
        save-after-copy = false
        default-hide-toolbars = false
        primary-highlighter = "freehand"
        disable-notifications = true
        brush-smooth-history-size = 1

        [font]
        family = "${fonts.monospace}"
        style = "Regular"

        [color-palette]
        palette = [
          "${brred}",
          "${brmagenta}",
          "${yellow}",
          "${blue}",
          "${green}",
          "${teal}",
          "${fg}"
        ]
      '';
  };
}
