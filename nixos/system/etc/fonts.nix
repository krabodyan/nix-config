{ pkgs, config, ... }: {
  fonts.packages = with pkgs; [
    corefonts
    font-awesome
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    roboto
    twemoji-color-font
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontDir.enable = true;
  fonts.fontconfig = {
    enable = true;
    antialias = true;
    hinting.enable = true;
    cache32Bit = true;
    defaultFonts = {
      serif = [ "Roboto Medium" ];
      sansSerif = [ "Roboto Medium" ];
      monospace = [ config.font ];
      emoji = [ "SymbolsNerdFont" "FontAwesome" "Noto Color Emoji" ];
    };
  };

}
