{
  services.dbus = {
    enable = true;
  };

  services.journald = {
    extraConfig = ''
      Compress=yes
      SystemMaxUse=100M
    '';
  };

  services.earlyoom = {
    enable = false;
  };

  security.pam.loginLimits = [{
    domain = "krabodyan";
    type = "soft";
    item = "core";
    value = "unlimited";
  }];

  security.pam.services.hyprlock = {};

  # services.xserver.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
}
