{ config, ... }: {
  programs.foot = {
    enable = true;
    server.enable = false;
    settings = {
      main = {
        term = "xterm-256color";
        font = "${config.font}:size=11";
        font-bold = "${config.font}:style=Bold:size=11";
        font-italic = "${config.font}:style=Italic:size=11";
        font-bold-italic = "${config.font}:style=Bold Italic:size=11";
        box-drawings-uses-font-glyphs = false;
        pad = "30x20";
        dpi-aware = "yes";
        initial-window-size-pixels = "880x600";
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

      colors = {
        alpha = "${config.colors.opacity}";
        background = "${config.colors.bg}"; #"2e3440"; #"1b1d22";
        foreground = "${config.colors.fg}"; #"eaf2f1";
        flash = "${config.colors.fg-bright}";
        flash-alpha = 0.7;

        regular0 = "${config.colors.black}"; # чорний
        regular1 = "${config.colors.red}"; # червоний
        regular2 = "${config.colors.green}"; # зелений
        regular3 = "${config.colors.yellow}"; # жовтий
        regular4 = "${config.colors.blue}"; # синій
        regular5 = "${config.colors.magenta}"; # пурпурний
        regular6 = "${config.colors.cyan}"; # бірюзовий
        regular7 = "${config.colors.fg-bright}"; #"bfd0f2"; #"eaf2f1";  # білий
        #bright0="696d77";   # яскраво-чорний
        #bright1="ff657a";   # яскраво-червоний
        #bright2="66ff00";   # яскраво-зелений
        #bright3="fbe74a";   # яскраво-жовтий
        #bright4="30d5c8";   # яскраво-синій
        #bright5="bf00c0";   # яскраво-пурпурний
        #bright6="9cd1bb";   # яскраво-бірюзовий
        #bright7="${config.colors.fg-bright}"; #"bfd0f2";#"eaf2f1";   # яскраво-білий
      };
    };
  };
}
