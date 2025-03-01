{ pkgs, theme, ... }: {
  home.packages = [ pkgs.vesktop ];
  xdg.configFile."vesktop/settings/quickCss.css".text = with theme; ''
    * {
      font-family: "${font}" !important;
      font-weight: bold !important;
      font-size: 15px !important;
    }
  '';
}
