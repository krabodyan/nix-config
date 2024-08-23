{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    corefonts
    font-awesome
    noto-fonts
    noto-fonts-emoji
    roboto
    noto-fonts-cjk-sans
    (nerdfonts.override {
      fonts = [
        "NerdFontsSymbolsOnly"
        # "IosevkaTerm"
        "JetBrainsMono"
      ];
    })
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Roboto Medium" ];
      sansSerif = [ "Roboto Medium" ];
      monospace = [ config.font ];
      emoji = [ "FontAwesome" ];
    };
  };
  xdg.configFile."fontconfig/fonts.conf".source = ./fonts.conf;
}
