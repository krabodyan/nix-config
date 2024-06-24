{
  imports = [ ./tlp.nix ];
  services = {
    printing.enable = true;
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
