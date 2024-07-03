{ pkgs, ... }: {
  home.packages = with pkgs; [
    corefonts
    #jetbrains-mono
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
  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
    serif = [ "Roboto Medium" ];
    sansSerif = [ "Roboto Medium" ];
    monospace = [ "JetBrains Mono Medium" ];
  };
}
