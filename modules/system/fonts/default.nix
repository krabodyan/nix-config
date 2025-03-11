{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.packages.fonts;
in {
  options = {
    module.packages.fonts = {
      enable = mkEnableOption "enable fonts";
      monospace = mkOption {
        type = lib.types.str;
      };
      serif = mkOption {
        type = lib.types.str;
      };
    };
  };
  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [
      corefonts
      font-awesome
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      roboto
      twemoji-color-font
      nerd-fonts.symbols-only
      nerd-fonts.iosevka-term
    ];

    fonts.fontDir.enable = true;
    fonts.fontconfig = {
      enable = true;
      antialias = true;
      hinting.enable = true;
      cache32Bit = true;
      defaultFonts = {
        serif = [cfg.serif];
        sansSerif = [cfg.serif];
        monospace = [cfg.monospace];
        emoji = ["SymbolsNerdFont" "FontAwesome" "Noto Color Emoji"];
      };
    };
  };
}
