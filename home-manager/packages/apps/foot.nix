{ config, pkgs, ... }: {
  home.packages = [ pkgs.xdg-terminal-exec ];
  xdg.configFile."xdg-terminals.list".text = ''
    foot.desktop
  '';
  programs.foot = {
    enable = true;
    server.enable = false;
    settings = {
      main = let
        # features = [ "ss20" ];
        # fontfeatures = lib.concatStringsSep ":fontfeatures=" features;
        font = "${config.font}:size=16";
      in {
        term = "xterm-256color";
        shell = "${pkgs.fish}/bin/fish";

        font = "${font}:weight=SemiBold";
        font-bold = "${font}:weight=Bold";
        font-italic = "${font}:weight=SemiBold:slant=Italic";
        font-bold-italic = "${font}:weight=Bold:slant=Italic";

        # box-drawings-uses-font-glyphs = false;
        pad = "20x16";
        dpi-aware = "no";
        resize-by-cells = "no";
        resize-delay-ms = 300;
        # line-height = "33px";
        # horizontal-letter-offset = "2px";
        initial-window-size-pixels = "1200x800";
        underline-offset = "10px";
        underline-thickness = "2px";
      };

      desktop-notifications = {
        command =
          "notify-send --app-name foot  --urgency \${urgency} --expire-time \${expire-time} \${title} \${body}";
        inhibit-when-focused = "yes";
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

      colors = with config.colors; {
        background = "${bg}";
        foreground = "${fg}";
        regular0 = "${black}";
        regular1 = "${red}";
        regular2 = "${green}";
        regular3 = "${yellow}";
        regular4 = "${blue}";
        regular5 = "${magenta}";
        regular6 = "${pink}";
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
