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
    printing.enable = false;
    earlyoom.enable = true;
    # nscd.enableNsncd = false;
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
