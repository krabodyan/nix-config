{
  lib,
  config,
  colors,
  systemFont,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.foot;
in {
  options = {
    module.foot = {
      enable = mkEnableOption "enable foot";
    };
  };
  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      server.enable = false;
      settings = {
        main = let
          features = [
            "ss12"
            # "ss14"
          ];
          fontfeatures = lib.concatStringsSep ":fontfeatures=" features;
          font = "${systemFont}:size=17:fontfeatures=${fontfeatures}";
        in {
          term = "foot";

          font = "${font}:weight=Regular";
          font-bold = "${font}:weight=SemiBold";
          font-italic = "${font}:weight=Regular:slant=Italic";
          font-bold-italic = "${font}:weight=SemiBold:slant=Italic";

          pad = "14x4 center";
          dpi-aware = "no";
          resize-by-cells = "no";
          resize-delay-ms = 300;
          resize-keep-grid = "no";
          initial-window-size-pixels = "1200x800";
          underline-offset = "12px";
          underline-thickness = "1px";
        };

        desktop-notifications = {
          command = "notify-send --app-name foot --urgency \${urgency} --expire-time \${expire-time} \${title} \${body}";
          inhibit-when-focused = "no";
        };

        scrollback = {
          indicator-position = "none";
          lines = 2000;
        };

        url = {launch = "xdg-open \${url}";};

        cursor = {
          style = "beam";
          unfocused-style = "hollow";
          blink = "no";
        };

        key-bindings = {
          scrollback-up-line = "Mod1+Control+k";
          scrollback-down-line = "Mod1+Control+j";
          show-urls-launch = "Mod1+Control+o";
        };

        colors = with colors; {
          selection-background = surface2;
          selection-foreground = fg;
          background = bg;
          foreground = fg;
          regular0 = black;
          regular1 = red;
          regular2 = green;
          regular3 = yellow;
          regular4 = blue;
          regular5 = magenta;
          regular6 = cyan;
          regular7 = fg;
          bright0 = brblack;
          bright1 = brred;
          bright2 = brgreen;
          bright3 = bryellow;
          bright4 = brblue;
          bright5 = brmagenta;
          bright6 = cyan;
          bright7 = fg-bright;
          dim0 = surface2;
          dim1 = "b33945";
          dim2 = "2ea12a";
          dim3 = "ccc668";
          dim4 = "6ea4cc";
          dim5 = "cc7cb6";
          dim6 = "70ccca";
          dim7 = overlay1;
        };
      };
    };
  };
}
