{
  config,
  lib,
  pkgs,
  ...
}:
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
          features = [
            "cv04"
            "cv14"
            "ss02"
            "cv18"
            "cv16"
            "zero"
          ];
          formattedFeatures = lib.concatStringsSep ":fontfeatures=" features;
          font = "${config.font}:size=14.5:fontfeatures=${formattedFeatures}";
        in
        {
          term = "xterm-256color";
          shell = "${pkgs.fish}/bin/fish";

          font = "${font}:weight=Regular";
          font-bold = "${font}:weight=SemiBold";
          font-italic = "${font}:slant=Italic";
          font-bold-italic = "${font}:weight=SemiBold:slant=Italic";

          box-drawings-uses-font-glyphs = false;
          pad = "24x18";
          dpi-aware = false;
          resize-by-cells = false;
          resize-delay-ms = 300;
          # line-height = "33px";
          # horizontal-letter-offset = "2px";
          initial-window-size-pixels = "1200x800";
          underline-offset = "10px";
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
