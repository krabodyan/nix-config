{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.locale;
in {
  options = {
    module.locale = {
      enable = mkEnableOption "enable locale";
    };
  };
  config = mkIf cfg.enable {
    i18n = let
      us = "en_US.UTF-8";
    in {
      defaultLocale = us;
      extraLocaleSettings = {
        LC_ADDRESS = us;
        LC_IDENTIFICATION = us;
        LC_MEASUREMENT = us;
        LC_MONETARY = us;
        LC_NAME = us;
        LC_NUMERIC = us;
        LC_PAPER = us;
        LC_TELEPHONE = us;
        LC_TIME = us;
      };
      supportedLocales = ["${us}/UTF-8"];
    };
  };
}
