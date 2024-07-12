{
  imports = [ ./tlp.nix ];

  systemd.coredump.extraConfig = ''
    Storage=none
  '';

  services = {
    printing.enable = false;
    earlyoom.enable = false;
    nscd = {
      enableNsncd = false;
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
