{
  hostname,
  yes,
  no,
  ...
}: {
  module = {
    bluetooth = no;
    bootloader = yes;
    console = yes;
    libvirtd = no;
    locale = yes;
    nix-config = yes;
    sound = yes;
    ssd-btrfs = yes;
    time = yes;
    tmpfs = yes;
    users = yes;
    virtualbox = no;

    udev-rules = {
      enable = true;
      platformio = true;
    };

    packages = {
      enable = true;
      steam = true;
      fonts = yes;
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

    services = {
      tlp = {
        enable = true;
        enableDaemon = false;
      };
      dbus-broker = yes;
      docker = {
        enable = true;
        storageDriver = "overlay2";
      };
      earlyoom = no;
      systemd-config = yes;
    };

    networking = {
      dhcpcd = {
        enable = true;
        inherit hostname;
      };
      iwd = {
        enable = true;
        enableDaemon = false;
      };
    };

    graphics = {
      minimal = yes;
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
