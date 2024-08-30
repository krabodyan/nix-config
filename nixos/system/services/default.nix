{
  imports = [ ./tlp.nix ];
  systemd.coredump.enable = false;
  systemd.extraConfig = ''
    DefaultTimeoutStartSec=15s
    DefaultTimeoutStopSec=15s
  '';
  services = {
    printing.enable = false;
    earlyoom.enable = false;
    nscd.enableNsncd = false;
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
