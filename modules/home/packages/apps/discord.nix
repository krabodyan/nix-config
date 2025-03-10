{
  pkgs,
  systemFont,
  ...
}: {
  home.packages = [pkgs.vesktop];
  xdg.configFile."vesktop/settings/quickCss.css".text = ''
    * {
      font-family: "${systemFont}" !important;
      font-weight: bold !important;
      font-size: 15px !important;
    }
  '';
}
