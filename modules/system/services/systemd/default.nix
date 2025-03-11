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
      enable = mkEnableOption "enable minimal systemd settings";
    };
  };
  config = mkIf cfg.enable {
    systemd.coredump.enable = false;
    systemd.extraConfig = ''
      DefaultTimeoutStartSec=15s
      TimeoutStartSec=15s
      DefaultTimeoutStopSec=15s
      TimeoutStopSec=15s
      DefaultTimeoutAbortSec=20sec
      TimeoutAbortSec=20sec
    '';
    services = {
      logind.killUserProcesses = true;
      journald.extraConfig = ''
        Compress=yes
        SystemMaxUse=100M
      '';
    };
  };
}
