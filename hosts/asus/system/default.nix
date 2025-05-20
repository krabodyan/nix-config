{hostname, ...}: {
  module = {
    bluetooth.enable = false;
    bootloader.enable = true;
    tmpfs.enable = true;
    ssd-btrfs.enable = true;
    sound.enable = true;
    nix-config.enable = true;
    time.enable = true;
    console.enable = true;
    users.enable = true;
    locale.enable = true;
    libvirtd.enable = false;
    virtualbox.enable = false;
    udev-rules = {
      enable = true;
      platformio = true;
    };

    packages = {
      enable = true;
      steam = true;
      fonts.enable = true;
    };

    xdg-portal = {
      enable = true;
      terminal = "foot.desktop";
      portals = ["gtk" "wlr"];
    };

    security = {
      pam.enable = true;
      sudo.enable = true;
    };

    services = {
      tlp = {
        enable = true;
        enableDaemon = false;
      };
      k3s-worker = {
        enable = false;
        server = "https://192.168.1.155:6443";
        token = "99d12cbd-03d2-4693-bc9b-55ad00c96097";
      };
      systemd-config.enable = true;
      earlyoom.enable = false;
      dbus-broker.enable = true;
      docker = {
        enable = true;
        storageDriver = "overlay2";
      };
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
      minimal.enable = true;
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
