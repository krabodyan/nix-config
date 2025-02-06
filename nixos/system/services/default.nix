{
  imports = [ ./tlp.nix ./docker.nix ];
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
    printing.enable = false;
    systembus-notify.enable = true;
    earlyoom = {
      enable = true;
      freeMemThreshold = 3;
      freeMemKillThreshold = 2;
      enableNotifications = true;
      extraArgs = [ "--prefer" "'^firefox$'" "--avoid" "'^steam$'" ];
    };
    dbus = {
      enable = true;
      implementation = "broker";
    };
    journald.extraConfig = ''
      Compress=yes
      SystemMaxUse=100M
    '';
  };
}
