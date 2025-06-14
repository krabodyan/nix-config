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
    boot.initrd.systemd.extraConfig = ''
      [Manager]
      DefaultTimeoutStopSec=15s
      DefaultTimeoutStartSec=15s
      DefaultTimeoutAbortSec=20sec
    '';
    systemd.extraConfig = config.boot.initrd.systemd.extraConfig;
    services = {
      logind = {
        lidSwitch = "suspend";
        suspendKey = "suspend";
        hibernateKey = "suspend";
        killUserProcesses = true;
      };
      journald.extraConfig = ''
        Compress=yes
        SystemMaxUse=100M
      '';
    };
  };
}
