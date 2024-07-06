{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-emoji
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
      emoji = [ "Noto Color Emoji" ];
    };
  };
  xdg.configFile."fontconfig/fonts.conf".source = ./fonts.conf;
}
