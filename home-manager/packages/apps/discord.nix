{
  pkgs,
  theme,
  ...
}: {
  home.packages = [pkgs.vesktop];
  xdg.configFile."vesktop/settings/quickCss.css".text = ''
    * {
      font-family: "${theme.font}" !important;
      font-weight: bold !important;
      font-size: 15px !important;
    }
  '';
}
