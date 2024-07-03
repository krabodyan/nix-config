{ pkgs, config, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    #font = "JetBrainsMono Nerd Font Bold 10";
    terminal = "foot";
    location = "bottom";
    extraConfig = {
      matching = "prefix";
      modi = "drun";
      display-drun = "";
      display-clipboard = "";
      drun-display-format = "{name}";
    };
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          font = "${config.font} Bold 10";
          bg = mkLiteral "#${config.colors.bg}"; # 99
          fg = mkLiteral "#${config.colors.fg-dark}";
          red = mkLiteral "#${config.colors.red}";
          fg-bright = mkLiteral "#${config.colors.fg}";
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
          border-radius = 12;
          border = 2;
          border-color = mkLiteral "#${config.colors.accent}";
          background-color = mkLiteral "@bg";
        };

        mainbox = {
          background-color = mkLiteral "@bg";
          children = map mkLiteral [ "inputbar" "listview" ];
        };

        listview = {
          scrollbar = false;
          columns = 1;
          lines = 2;
        };

        inputbar = {
          text-color = mkLiteral "@fg-bright";
          children = map mkLiteral [ "prompt" "entry" ];
          border-radius = 10;
        };

        prompt = {
          text-color = mkLiteral "@fg-bright";
          background-color = mkLiteral "transparent";
          enabled = true;
          border-radius = 0;
        };

        entry = {
          text-color = mkLiteral "@fg-bright";
          border-radius = 17;
          border = 2;
          border-color = mkLiteral "#${config.colors.accent}";
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
          #background-color = mkLiteral "@bg";
          text-color = mkLiteral "@fg";
        };

        "element.normal.urgent" = {
          #background-color = mkLiteral "@bg";
          text-color = mkLiteral "@fg";
        };

        "element.normal.active" = {
          #background-color = mkLiteral "@bg";
          text-color = mkLiteral "@fg-bright";
        };

        "element.selected.normal" = {
          #background-color = mkLiteral "@bg";
          text-color = mkLiteral "@fg-bright";
        };

        "element.selected.urgent" = {
          #background-color = "@bg";
          text-color = mkLiteral "@red";
        };

        "element.selected.active" = {
          #background-color = mkLiteral "@bg";
          text-color = mkLiteral "@fg-bright";
        };

        "element.alternate.normal" = {
          #background-color = mkLiteral "@bg";
          text-color = mkLiteral "@fg";
        };

        "element.alternate.urgent" = {
          #background-color = mkLiteral "@bg";
          text-color = mkLiteral "@fg";
        };

        "element.alternate.active" = {
          #background-color = mkLiteral "@bg";
          text-color = mkLiteral "@fg";
        };
      };
  };
}
