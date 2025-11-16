{yes, ...}: {
  module = {
    agenix = yes;
    bootloader = yes;
    console = yes;
    locale = yes;
    nix-config = yes;
    distrobox = yes;
    sound = yes;
    ssd-btrfs = yes;
    time = yes;
    tmpfs = yes;
    users = yes;
    steam = yes;
    packages = yes;
    fonts = yes;
    udev-rules = yes;
    libvirtd = yes;
    # printing = yes;

    podman = {
      enable = true;
      nvidia = true;
    };

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
