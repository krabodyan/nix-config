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
          font = "${config.font}:size=10";
        in
        {
          term = "xterm-256color";
          shell = "${pkgs.fish}/bin/fish";

          inherit font;
          font-bold = "${font}:style=Bold";
          font-italic = "${font}:style=Italic";
          font-bold-italic = "${font}:style=Bold Italic";

          box-drawings-uses-font-glyphs = false;
          pad = "30x20";
          dpi-aware = "yes";
          resize-by-cells = false;
          resize-delay-ms = 0;
          initial-window-size-pixels = "950x620";
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

      colors = with config.colors; {
        alpha = "${opacity}";
        background = "${bg}";
        foreground = "${fg}";
        flash = "${fg-bright}";
        flash-alpha = 0.7;

        regular0 = "${black}";
        regular1 = "${red}";
        regular2 = "${green}";
        regular3 = "${yellow}";
        regular4 = "${blue}";
        regular5 = "${magenta}";
        regular6 = "${cyan}";
        regular7 = "${fg-bright}";
        bright0 = "${black}";
        bright1 = "${red}";
        bright2 = "${green}";
        bright3 = "${yellow}";
        bright4 = "${blue}";
        bright5 = "${magenta}";
        bright6 = "${cyan}";
        bright7 = "${fg-bright}";

      };
    };
  };
}
