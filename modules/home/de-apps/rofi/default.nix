{
  lib,
  pkgs,
  config,
  colors,
  systemFont,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.rofi;
in {
  options = {
    module.rofi = {
      enable = mkEnableOption "enable rofi";
    };
  };
  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      terminal = "foot";
      location = "bottom";
      extraConfig = {
        matching = "prefix";
        modi = "drun";
        display-drun = "";
        display-clipboard = "";
        drun-display-format = "{name}";
        sort = true;
        sorting-method = "fzf";
      };
      theme = with colors.hex; let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        "*" = {
          font = "${systemFont} SemiBold 11";
          bg = mkLiteral "${bg}"; # 99
          fg = mkLiteral "${fg-dark}";
          red = mkLiteral "${red}";
          fg-bright = mkLiteral "${fg}";
          background-color = mkLiteral "@bg";
          text-color = mkLiteral "@fg";
          separatorcolor = mkLiteral "transparent";
          border = 0;
          margin = 0;
          padding = 0;
          spacing = 0;
        };

        window = {
          width = mkLiteral "364px";
          height = mkLiteral "134px";
          y-offset = -30;
          border-radius = 6;
          border = 2;
          border-color = mkLiteral "${border}";
          background-color = mkLiteral "@bg";
        };

        mainbox = {
          background-color = mkLiteral "@bg";
          children = map mkLiteral ["inputbar" "listview"];
        };

        listview = {
          scrollbar = false;
          columns = 1;
          lines = 2;
        };

        inputbar = {
          text-color = mkLiteral "@fg-bright";
          children = map mkLiteral ["prompt" "entry"];
        };

        prompt = {
          text-color = mkLiteral "@fg-bright";
          background-color = mkLiteral "transparent";
          enabled = true;
        };

        entry = {
          text-color = mkLiteral "@fg-bright";
          border-radius = 5;
          border = 2;
          border-color = mkLiteral "${border}";
          background-color = mkLiteral "transparent";
          placeholder = "";
          cursor = mkLiteral "underline";
          blink = false;
          padding = mkLiteral "5 10";
          margin = mkLiteral "20 20 10 20";
        };

        element = {
          margin = 5;
          background-color = mkLiteral "transparent";
        };

        element-text = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
          expand = true;
          horizontal-align = mkLiteral "0.5";
          vertical-align = mkLiteral "0.5";
          highlight = mkLiteral "None";
        };

        "element.normal.normal" = {
          text-color = mkLiteral "@fg";
        };

        "element.normal.urgent" = {
          text-color = mkLiteral "@fg";
        };

        "element.normal.active" = {
          text-color = mkLiteral "@fg-bright";
        };

        "element.selected.normal" = {
          text-color = mkLiteral "@fg-bright";
        };

        "element.selected.urgent" = {
          text-color = mkLiteral "@red";
        };

        "element.selected.active" = {
          text-color = mkLiteral "@fg-bright";
        };

        "element.alternate.normal" = {
          text-color = mkLiteral "@fg";
        };

        "element.alternate.urgent" = {
          text-color = mkLiteral "@fg";
        };

        "element.alternate.active" = {
          text-color = mkLiteral "@fg";
        };
      };
    };
  };
}
