{ config, pkgs, ... }:
{
  home.packages = [ pkgs.xdg-terminal-exec ];
  xdg.configFile."xdg-terminals.list".text = ''
    org.codeberg.dnkl.foot.desktop
  '';
  programs.foot = {
    enable = true;
    server.enable = false;
    settings = {
      main =
        let
          font = "${config.font}:size=12:style:Medium";
        in
        {
          term = "xterm-256color";
          shell = "${pkgs.fish}/bin/fish";

          inherit font;
          font-bold = "${font}:style=Bold";
          font-italic = "${font}:style=Italic";
          font-bold-italic = "${font}:style=Bold:style=Italic";

          box-drawings-uses-font-glyphs = false;
          pad = "24x18";
          dpi-aware = "yes";
          resize-by-cells = false;
          resize-delay-ms = 0;
          initial-window-size-pixels = "1200x800";
          underline-offset = "5px";
          underline-thickness = "1px";
        };

      scrollback = {
        indicator-position = "none";
        lines = 250;
      };

      url = {
        launch = "xdg-open \${url}";
        protocols = "http, https, ftp, ftps, file";
      };

      cursor = {
        style = "underline";
        blink = "no";
      };

      key-bindings = {
        scrollback-up-line = "Control+k";
        scrollback-down-line = "Control+l";
      };

      colors = with config.colors; {
        alpha = "${opacity}";
        background = "${bg}";
        foreground = "${fg}";
        regular0 = "${black}";
        regular1 = "${red}";
        regular2 = "${green}";
        regular3 = "${yellow}";
        regular4 = "${accent}";
        regular5 = "${magenta}";
        regular6 = "${accent}";
        regular7 = "${fg-bright}";
        bright0 = "${black}";
        bright1 = "${red}";
        bright2 = "${green}";
        bright3 = "${yellow}";
        bright4 = "${accent}";
        bright5 = "${magenta}";
        bright6 = "${accent}";
        bright7 = "${fg-bright}";
      };
    };
  };
}
