{ pkgs, config, ... }: {
  home.packages = [ pkgs.vesktop ];
  xdg.configFile."vesktop/settings/quickCss.css".text = ''
    @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css");
    @import "https://fonts.google.com/specimen/JetBrains+Mono?query=jet";
    * {
        font-family: "${config.font}" !important;
    }
  '';
}
