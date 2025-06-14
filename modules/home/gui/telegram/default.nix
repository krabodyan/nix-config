{
  lib,
  pkgs,
  config,
  mkAssociations,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.telegram;
in {
  options = {
    module.telegram = {
      enable = mkEnableOption "telegram";
    };
  };
  config = let
    client = pkgs.telegram-desktop;
    name = "org.telegram.desktop";
    exec = "Telegram";
  in
    mkIf cfg.enable {
      home.packages = [client];

      xdg.desktopEntries.${name} = {
        name = "Telegram Desktop";
        exec = "env QT_QPA_PLATFORMTHEME=gtk3 ${exec} -- %u";
      };

      xdg.mimeApps.defaultApplications = mkAssociations {
        types = [
          "x-scheme-handler/tg"
          "application/x-xdg-protocol-tg"
        ];
        desktop = "${name}.desktop";
      };
    };
}
