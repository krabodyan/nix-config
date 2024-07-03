{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    roboto
    noto-fonts-cjk-sans
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "JetBrainsMono" ]; })
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Roboto Medium" ];
      sansSerif = [ "Roboto Medium" ];
      monospace = [ config.font ];
      emoji = [ config.font ];
    };
  };
  xdg.configFile."fontconfig/fonts.conf".source = ./fonts.conf;
}
