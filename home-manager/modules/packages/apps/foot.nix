{ config, pkgs, ... }: {
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
          initial-window-size-pixels = "880x600";
          underline-offset = "5px";
          underline-thickness = "1px";
        };

      scrollback = {
        indicator-position = "none";
        lines = 100;
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
        background = "${bg}"; #"2e3440"; #"1b1d22";
        foreground = "${fg}"; #"eaf2f1";
        flash = "${fg-bright}";
        flash-alpha = 0.7;

        regular0 = "${black}"; # чорний
        regular1 = "${red}"; # червоний
        regular2 = "${green}"; # зелений
        regular3 = "${yellow}"; # жовтий
        regular4 = "${blue}"; # синій
        regular5 = "${magenta}"; # пурпурний
        regular6 = "${cyan}"; # бірюзовий
        regular7 = "${fg-bright}"; #"bfd0f2"; #"eaf2f1";  # білий
        #bright0="696d77";   # яскраво-чорний
        #bright1="ff657a";   # яскраво-червоний
        #bright2="66ff00";   # яскраво-зелений
        #bright3="fbe74a";   # яскраво-жовтий
        #bright4="30d5c8";   # яскраво-синій
        #bright5="bf00c0";   # яскраво-пурпурний
        #bright6="9cd1bb";   # яскраво-бірюзовий
        #bright7="${fg-bright}"; #"bfd0f2";#"eaf2f1";   # яскраво-білий
      };
    };
  };
}
