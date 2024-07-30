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
          font = "${config.font}:size=12";
        in
        {
          term = "xterm-256color";
          shell = "${pkgs.fish}/bin/fish";

          font = "${font}:weight=Medium";
          font-bold = "${font}:weight=Bold";
          font-italic = "${font}:slant=Italic";
          font-bold-italic = "${font}:weight=Bold:slant=Italic";

          box-drawings-uses-font-glyphs = false;
          pad = "24x18";
          dpi-aware = "yes";
          resize-by-cells = false;
          resize-delay-ms = 1000;
          initial-window-size-pixels = "1200x800";
          underline-offset = "7px";
          underline-thickness = "2px";
        };

      scrollback = {
        indicator-position = "none";
        lines = 2000;
      };

      url = {
        launch = "xdg-open \${url}";
        protocols = "http, https, ftp, ftps, file";
      };

      cursor = {
        style = "underline";
        unfocused-style = "unchanged";
        underline-thickness = "2px";
        blink = "no";
      };

      key-bindings = {
        scrollback-up-line = "Mod1+Shift+k";
        scrollback-down-line = "Mod1+Shift+j";
      };
      # mouse.alternate-scroll-mode = false;

      colors = with config.colors; {
        alpha = "${opacity}";
        background = "${bg}";
        foreground = "${fg}";
        regular0 = "${black}";
        regular1 = "${red}";
        regular2 = "${green}";
        regular3 = "${yellow}";
        regular4 = "${blue}";
        regular5 = "${magenta}";
        regular6 = "${cyan}";
        regular7 = "${fg}";
        bright0 = "${brblack}";
        bright1 = "${brred}";
        bright2 = "${brgreen}";
        bright3 = "${bryellow}";
        bright4 = "${brblue}";
        bright5 = "${brmagenta}";
        bright6 = "${brcyan}";
        bright7 = "${fg-bright}";
      };
    };
  };
}
