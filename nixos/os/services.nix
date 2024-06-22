{ pkgs, ... }: {
  services.dbus.enable = true;
  services.dbus.implementation = "broker";
  services.printing.enable = false;

  services.journald = {
    extraConfig = ''
      Compress=yes
      SystemMaxUse=100M
    '';
  };

  services.earlyoom.enable = false;

  security.pam.loginLimits = [{
    domain = "krabodyan";
    type = "soft";
    item = "core";
    value = "unlimited";
  }];

  security.pam.services.swaylock = {};

  # services.xserver.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
}
