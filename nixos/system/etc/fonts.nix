{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    corefonts
    font-awesome
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    roboto
    twemoji-color-font
    (nerdfonts.override {
      fonts = [
        "NerdFontsSymbolsOnly"
        "JetBrainsMono"
      ];
    })
  ];

}
