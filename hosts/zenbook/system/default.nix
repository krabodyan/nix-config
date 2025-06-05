{yes, ...}: {
  module = {
    agenix = yes;
    bootloader = yes;
    console = yes;
    locale = yes;
    nix-config = yes;
    sound = yes;
    time = yes;
    tmpfs = yes;
    users = yes;
    udev-rules = yes;
    packages = yes;
    fonts = yes;

    xdg-portal = {
      enable = true;
      terminal = "foot.desktop";
      portals = ["gtk" "wlr"];
    };

    security = {
      pam = yes;
      sudo = yes;
    };

    services = {
      auto-cpufreq = yes;
      getty-autologin = yes;
      dbus-broker = yes;
      systemd-config = yes;
      earlyoom = yes;
    };

    networking = {
      dhcpcd = yes;
      iwd = {
        enable = true;
        enableDaemon = true;
      };
    };

    graphics = {
      minimal = yes;
      amdgpu = yes;
    };
  };
}
