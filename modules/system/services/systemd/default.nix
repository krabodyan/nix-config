{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.services.systemd-config;
in {
  options = {
    module.services.systemd-config = {
      enable = mkEnableOption "minimal systemd settings";
    };
  };
  config = mkIf cfg.enable {
    systemd.coredump.enable = false;
    systemd.settings.Manager = {
      DefaultTimeoutStopSec = "10s";
      DefaultTimeoutStartSec = "10s";
      DefaultTimeoutAbortSec = "10s";
    };
    services = {
      logind.settings.Login = {
        HandleLidSwitch = "suspend";
        HandleSuspendKey = "suspend";
        HandleHibernateKey = "suspend";
        KillUserProcesses = true;
      };
      journald.extraConfig = ''
        Compress=yes
        SystemMaxUse=100M
      '';
    };
  };
}
