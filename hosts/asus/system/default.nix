{yes, ...}: {
  module = {
    agenix = yes;
    bootloader = yes;
    console = yes;
    locale = yes;
    nix-config = yes;
    podman = yes;
    sound = yes;
    ssd-btrfs = yes;
    time = yes;
    tmpfs = yes;
    users = yes;

    udev-rules = {
      enable = true;
      # platformio = true;
    };

    steam = yes;
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

    powerManagement = yes;

    services = {
      dbus-broker = yes;
      charge-threshold = yes;
      systemd-config = yes;
      earlyoom = yes;
    };

    networking = {
      dhcpcd = yes;
      iwd = {
        enable = true;
        enableDaemon = false;
      };
    };

    graphics = {
      minimal = {
        enable = true;
        enable32Bit = true;
      };
      intel = {
        enable = true;
        newer = true;
      };
      nvidia-hybrid = {
        enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
