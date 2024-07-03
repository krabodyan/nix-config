{
  imports = [ ./tlp.nix ];
  systemd.coredump.enable = false;
  services = {
    printing.enable = false;
    earlyoom.enable = false;
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
