{yes, ...}: {
  module = {
    agenix = yes;
    bootloader = yes;
    console = yes;
    fonts = yes;
    locale = yes;
    nix-config = yes;
    packages = yes;
    podman = yes;
    sound = yes;
    time = yes;
    tmpfs = yes;
    udev-rules = yes;
    users = yes;

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
      charge-threshold = yes;
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
