{ config, ... }:
{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Roboto Medium" ];
      sansSerif = [ "Roboto Medium" ];
      monospace = [ config.font ];
      emoji = [
        "SymbolsNerdFont"
        "FontAwesome"
        "Noto Color Emoji"
      ];
    };
  };
  xdg.configFile."fontconfig/fonts.conf".source = ./fonts.conf;
}
