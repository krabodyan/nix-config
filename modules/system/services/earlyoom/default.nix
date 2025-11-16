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
      enable = mkEnableOption "earlyoom killer daemon";
    };
  };
  config = mkIf cfg.enable {
    systemd.oomd.enable = false;
    services.systembus-notify.enable = true;
    services.earlyoom = {
      enable = true;
      enableNotifications = true;
      freeMemThreshold = 10;
      freeMemKillThreshold = 6;
    };
  };
}
