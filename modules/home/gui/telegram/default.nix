{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.telegram;
in {
  options = {
    module.telegram = {
      enable = mkEnableOption "enable telegram";
    };
  };
  config = let
    client = pkgs.telegram-desktop;
    name = "org.telegram.desktop";
    exec = "telegram-desktop";
  in
    mkIf cfg.enable {
      home.packages = [client];

      xdg.desktopEntries.${name} = {
        name = "Telegram Desktop";
        exec = "env QT_QPA_PLATFORMTHEME=gtk3 ${exec} -- %u";
      };
      xdg.mimeApps.defaultApplications = {
        "x-scheme-handler/tg" = ["${name}.desktop"];
      };
    };
}
