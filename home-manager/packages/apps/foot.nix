{ theme, pkgs, ... }: {
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
        font = "${theme.font}:size=18";
      in {
        term = "xterm-256color";
        shell = "${pkgs.fish}/bin/fish";

        font = "${font}:weight=Regular";
        font-bold = "${font}:weight=SemiBold";
        font-italic = "${font}:weight=Regular:slant=Italic";
        font-bold-italic = "${font}:weight=SemiBold:slant=Italic";

        # box-drawings-uses-font-glyphs = false;
        pad = "18x11 center";
        dpi-aware = "no";
        resize-by-cells = "no";
        resize-delay-ms = 300;
        resize-keep-grid = "no";
        initial-window-size-pixels = "1200x800";
        underline-offset = "12px";
        underline-thickness = "1px";
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

      url = { launch = "xdg-open \${url}"; };

      cursor = {
        style = "underline";
        unfocused-style = "unchanged";
        underline-thickness = "2px";
        blink = "no";
      };

      key-bindings = {
        scrollback-up-line = "Mod1+Control+k";
        scrollback-down-line = "Mod1+Control+j";
        show-urls-launch = "Mod1+Control+o";
      };

      colors = with theme; {
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
