{
  lib,
  config,
  colors,
  systemFont,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.alacritty;
in {
  options = {
    module.alacritty = {
      enable = mkEnableOption "enable alacritty";
    };
  };
  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        general = {
          live_config_reload = true;
        };
        font = {
          normal = { family = systemFont; style = "Regular"; };
          size = 17;
        };
        colors = with colors.hex; {
          primary = {
            foreground = fg;
            background = bg;
          };
        };
        window = {
          padding = {
            x = 10;
            y = 5;
          };
          dynamic_title = false;
          decorations = "None";
          dimensions = {
            lines = 100;
            columns = 80;
          };
        };
      };
    };
  };
}
