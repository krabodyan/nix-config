{
  lib,
  pkgs,
  fonts,
  hidpi,
  config,
  colors,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.rofi;
in {
  options = {
    module.rofi = {
      enable = mkEnableOption "rofi";
    };
  };
  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland-unwrapped;
      terminal = "${pkgs.foot}/bin/footclient";
      location = "bottom";
      modes = ["drun"];
      extraConfig = {
        modi = "drun";
        display-drun = "";
        display-clipboard = "";
        drun-display-format = "{name}";
        sort = true;
        sorting-method = "fzf";
      };
      theme = with colors.hex; let
        transparent = mkLiteral "transparent";
        inherit (config.lib.formats.rasi) mkLiteral;
        border = mkLiteral overlay0;
        bright = mkLiteral fg;
        dark = mkLiteral fg-dark;
        background = mkLiteral bg;
        urgent = mkLiteral red;
        fontsize =
          if hidpi
          then "14"
          else "11";
      in {
        "*" = {
          font = "${fonts.monospace} SemiBold ${fontsize}";
          background-color = background;
          text-color = dark;
          separatorcolor = transparent;
          border = 0;
          margin = 0;
          padding = 0;
          spacing = 0;
        };

        window = {
          width = mkLiteral (
            if hidpi
            then "480px"
            else "364px"
          );
          height = mkLiteral (
            if hidpi
            then "180px"
            else "134px"
          );
          y-offset = -40;
          border-radius = 6;
          border = 2;
          border-color = border;
          background-color = background;
        };

        mainbox = {
          background-color = background;
          children = map mkLiteral ["inputbar" "listview"];
        };

        listview = {
          scrollbar = false;
          columns = 1;
          lines = 2;
        };

        inputbar = {
          text-color = bright;
          children = map mkLiteral ["prompt" "entry"];
        };

        prompt = {
          text-color = bright;
          background-color = transparent;
          enabled = true;
        };

        entry = {
          border-radius = 5;
          border = 2;
          border-color = border;
          text-color = bright;
          background-color = transparent;
          placeholder = "";
          cursor-color = dark;
          blink = false;
          padding = mkLiteral (
            if hidpi
            then "10 20"
            else "5 10"
          );
          margin = mkLiteral (
            if hidpi
            then "25 25 15 25"
            else "20 20 10 20"
          );
        };

        element = {
          margin = 5;
          background-color = transparent;
        };

        element-text = {
          background-color = transparent;
          text-color = mkLiteral "inherit";
          expand = true;
          horizontal-align = mkLiteral "0.5";
          vertical-align = mkLiteral "0.5";
          highlight = mkLiteral "None";
        };

        "element.normal.normal" = {
          text-color = dark;
        };

        "element.normal.urgent" = {
          text-color = urgent;
        };

        "element.normal.active" = {
          text-color = bright;
        };

        "element.selected.normal" = {
          text-color = bright;
        };

        "element.selected.urgent" = {
          text-color = urgent;
        };

        "element.selected.active" = {
          text-color = bright;
        };

        "element.alternate.normal" = {
          text-color = dark;
        };

        "element.alternate.urgent" = {
          text-color = urgent;
        };

        "element.alternate.active" = {
          text-color = bright;
        };
      };
    };
  };
}
