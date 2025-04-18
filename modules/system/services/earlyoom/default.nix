{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.services.earlyoom;
in {
  options = {
    module.services.earlyoom = {
      enable = mkEnableOption "enable earlyoom killer daemon";
    };
  };
  config = mkIf cfg.enable {
    services.systembus-notify.enable = true;
    services.earlyoom = {
      enable = true;
      enableNotifications = true;
      freeMemThreshold = 8;
      freeMemKillThreshold = 5;
    };
  };
}
