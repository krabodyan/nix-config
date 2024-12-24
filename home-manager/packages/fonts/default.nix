{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    corefonts
    font-awesome
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    roboto
    twemoji-color-font
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka-term
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Roboto Medium" ];
      sansSerif = [ "Roboto Medium" ];
      monospace = [ config.font ];
      emoji = [ "SymbolsNerdFont" "FontAwesome" "Noto Color Emoji" ];
    };
  };
  xdg.configFile."fontconfig/fonts.conf".source = ./fonts.conf;
}
