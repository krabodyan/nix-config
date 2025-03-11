{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  cfg = config.module.locale;
in {
  options = {
    module.locale = {
      enable = mkEnableOption "enable locale";
      locale = mkOption {
        type = lib.types.str;
        example = "uk_UA.UTF-8";
      };
    };
  };
  config = mkIf cfg.enable {
    i18n = let
      inherit (cfg) locale;
    in {
      defaultLocale = locale;
      extraLocaleSettings = {
        LC_ADDRESS = locale;
        LC_IDENTIFICATION = locale;
        LC_MEASUREMENT = locale;
        LC_MONETARY = locale;
        LC_NAME = locale;
        LC_NUMERIC = locale;
        LC_PAPER = locale;
        LC_TELEPHONE = locale;
        LC_TIME = locale;
      };
      supportedLocales = ["${locale}/UTF-8"];
    };
  };
}
