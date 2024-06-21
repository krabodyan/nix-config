{ pkgs, ... }: {
  services.dbus.enable = true;

  services.printing.enable = true;
  hardware.sane.enable = true;
  services.ipp-usb.enable=true;
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];
  hardware.sane.disabledDefaultBackends = [ "v4l" ];

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
