{yes, ...}: {
  module = {
    agenix = yes;
    bluetooth = yes;
    bootloader = yes;
    console = yes;
    fonts = yes;
    locale = yes;
    nix-config = yes;
    packages = yes;
    podman = yes;
    distrobox = yes;
    sound = yes;
    time = yes;
    zram = yes;
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

    powerManagement = yes;

    services = {
      getty-autologin = yes;
      dbus-broker = yes;
      systemd-config = yes;
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
