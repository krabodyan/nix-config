{
  lib,
  pkgs,
  fonts,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.fonts;
in {
  options = {
    module.fonts = {
      enable = mkEnableOption "fonts";
    };
  };
  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [
      corefonts
      font-awesome_5
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      twemoji-color-font
      nerd-fonts.symbols-only
      nerd-fonts.iosevka-term
      roboto
    ];

    fonts.fontDir.enable = true;
    fonts.fontconfig = {
      enable = true;
      antialias = true;
      hinting.enable = true;
      cache32Bit = true;
      defaultFonts = {
        serif = [fonts.serif];
        sansSerif = [fonts.serif];
        monospace = [fonts.monospace];
        emoji = ["SymbolsNerdFont" "FontAwesome" "Noto Color Emoji"];
      };
    };
  };
}
